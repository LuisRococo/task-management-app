class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable, :rememberable, :validatable

  include AuthorizedPersona::Persona

  has_many :boards, foreign_key: :author
  has_many :tasks, foreign_key: :creator
  has_many :task_users
  has_many :tasks, through: :task_users
  
  has_many :team_members, class_name: 'User', foreign_key: :manager_id
  belongs_to :manager, class_name: 'User', optional: true

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

  def is_manager_or_manager_team?(manager)
    if authorization_tier == 'user'
      manager == @manager
    else
      self == manager
    end
  end

  private

  def capitalize_name
    first_name.capitalize!
    last_name.capitalize!
  end
end
