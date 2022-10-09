# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable, :rememberable, :validatable

  include AuthorizedPersona::Persona

  @@BOARDS_LIMIT = 10
  @@TRIAL_TIME_LIMIT_DAYS = 15
  @@TRIAL_MAX_TEAM_MEMBERS = 5

  has_many :boards, foreign_key: :author
  has_many :tasks, foreign_key: :creator
  has_many :task_users
  has_many :tasks, through: :task_users

  has_many :team_members, class_name: 'User', foreign_key: :manager_id
  belongs_to :manager, class_name: 'User', optional: true
  belongs_to :plan, optional: true

  scope :white_managers_white_list, -> { where(authorization_tier: 'manager').order('white_listed DESC') }

  authorization_tiers(
    user: 'User - limited access',
    manager: 'Manager - manages users and boards',
    admin: 'Admin - total access'
  )

  validates :authorization_tier, inclusion: { in: authorization_tier_names }
  before_save :capitalize_name
  validates :first_name, length: { minimum: 4, maximum: 25 }
  validates :last_name, length: { minimum: 4, maximum: 25 }

  def full_name
    "#{first_name} #{last_name}"
  end

  def user_on_task?(id)
    !tasks.find_by(id: id).nil?
  end

  def is_manager_or_manager_team?(user)
    if authorization_tier == 'user'
      manager == user
    else
      return true if self == user

      team_members.find_by(id: user.id).present?
    end
  end

  def self.BOARDS_LIMIT
    @@BOARDS_LIMIT
  end

  def self.TRIAL_TIME_LIMIT_DAYS
    @@TRIAL_TIME_LIMIT_DAYS
  end

  def self.TRIAL_MAX_TEAM_MEMBERS
    @@TRIAL_MAX_TEAM_MEMBERS
  end

  def max_boards_limit_reached?
    boards.count >= @@BOARDS_LIMIT
  end

  def max_team_members
    return nil unless authorization_tier == 'manager'

    has_free_trial? ? @@TRIAL_MAX_TEAM_MEMBERS : plan.member_quantity
  end

  def max_team_members_reached?
    return true if max_team_members.nil?

    team_members.count >= max_team_members
  end

  def calculate_has_trial_expired?
    return true if trial_block

    days_of_trial_used = (Time.zone.now - created_at.to_time) / 1.day
    days_of_trial_used = days_of_trial_used.to_i
    days_of_trial_used > @@TRIAL_TIME_LIMIT_DAYS
  end

  def add_white_list
    self.white_listed = true
    self.remove_pay_block
    self.save
  end

  def remove_white_list
    self.white_listed = false
    self.save
  end

  def white_listed?
    manager = authorization_tier == 'user' ? self.manager : self
    manager.white_listed
  end

  def has_free_trial?
    manager = authorization_tier == 'user' ? self.manager : self
    !manager.user_has_plan? && !trial_block
  end

  def end_trial_period
    return unless authorization_tier == 'manager' && has_free_trial?
    self.trial_block = true
    save!
  end

  def user_has_plan?
    !!plan
  end

  def add_pay_block
    return if white_listed?
    self.pay_block = true
    self.save
  end

  def remove_pay_block
    self.pay_block = false
    save
  end

  def has_payment_block?
    manager = authorization_tier == 'user' ? self.manager : self
    manager.pay_block
  end

  def has_trial_block?
    manager = authorization_tier == 'user' ? self.manager : self
    manager.trial_block
  end

  def has_user_block?
    manager = authorization_tier == 'user' ? self.manager : self
    manager.user_block
  end

  def toggle_block_user
    return unless authorization_tier == 'manager'
    self.user_block = !user_block
    save
  end

  def has_payment_expired?
    raise StandardError, 'User has no plan' unless user_has_plan?

    days_after_payment = (Time.zone.now - paid_date.to_time) / 1.day
    days_after_payment = days_after_payment.to_i
    days_after_payment > plan.duration_in_days
  end

  def has_access_to_user_crud?(target_user)
    return true if target_user == self
    return true if authorization_tier == 'admin'

    is_manager_or_manager_team?(target_user) && authorization_tier == 'manager'
  end

  def can_plan_be_set?
    !user_has_plan? && authorization_tier == 'manager'
  end

  def change_plan(plan_to_add)
    self.plan = plan_to_add
    self.trial_block = false
    self.pay_block = true
    save!
  end

  def access_to_plan_show_page
    authorization_tier == 'manager'
  end

  def stripe_customer_id_or_create
    if stripe_user_id.nil?
      customer_info = {
        email: email,
        description: "Customer with name '#{full_name}'",
        name: full_name
      }
      customer_id = Stripe::Customer.create(customer_info)
      self.stripe_user_id = customer_id
    end
    stripe_user_id
  end

  private

  def capitalize_name
    first_name.capitalize!
    last_name.capitalize!
  end
end
