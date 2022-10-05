class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable, :rememberable, :validatable

  include AuthorizedPersona::Persona

  @@BOARDS_LIMIT = 10
  @@TRIAL_TIME_LIMIT_DAYS = 15

  has_many :boards, foreign_key: :author
  has_many :tasks, foreign_key: :creator
  has_many :task_users
  has_many :tasks, through: :task_users
  
  has_many :team_members, class_name: 'User', foreign_key: :manager_id
  belongs_to :manager, class_name: 'User', optional: true
  belongs_to :plan, optional: true

  authorization_tiers(
    user: "User - limited access",
    manager: "Manager - manages users and boards",
    admin: "Admin - total access"
  )

  validates :authorization_tier, inclusion: { in: authorization_tier_names }
  before_save :capitalize_name
  validates :first_name, length: { minimum: 4, maximum: 25 }
  validates :last_name, length: { minimum: 4, maximum: 25 }


  def full_name
    first_name + ' ' + last_name
  end

  def user_on_task?(id)
    !tasks.find_by_id(id).nil?
  end

  def is_manager_or_manager_team?(manager_to_compare)
    if authorization_tier == 'user'
      manager == manager_to_compare
    else
      self == manager_to_compare
    end
  end

  def self.BOARDS_LIMIT
    @@BOARDS_LIMIT
  end

  def self.TRIAL_TIME_LIMIT_DAYS
    @@TRIAL_TIME_LIMIT_DAYS
  end

  def max_boards_limit_reached?
    boards.count >= @@BOARDS_LIMIT
  end

  def calculate_has_trial_expired?
    return true if trial_block
    days_of_trial_used = (Time.now - created_at.to_time) / 1.day
    days_of_trial_used = days_of_trial_used.to_i
    days_of_trial_used > @@TRIAL_TIME_LIMIT_DAYS
  end

  def has_free_trial?
    return false unless authorization_tier == 'manager'
    !user_has_plan? && !trial_block
  end

  def end_trial_period
    if has_free_trial?
      self.trial_block = true
      self.save!
    end
  end

  def user_has_plan?
    !!plan
  end

  def has_payment_expired?
    raise Exception.new "User has no plan" unless user_has_plan?
    days_after_payment = (Time.now - paid_date.to_time) / 1.day
    days_after_payment = days_after_payment.to_i
    days_after_payment > plan.duration_in_days
  end

  private

  def capitalize_name
    first_name.capitalize!
    last_name.capitalize!
  end
end
