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
  belongs_to :plan

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

  def has_trial_expired?
    return true if trial_block
    days_of_trial_used = (Time.now - created_at.to_time) / 1.day
    days_of_trial_used = days_of_trial_used.to_i
    days_of_trial_used > @@TRIAL_TIME_LIMIT_DAYS
  end

  private

  def capitalize_name
    first_name.capitalize!
    last_name.capitalize!
  end
end
