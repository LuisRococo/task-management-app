class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :rememberable, :validatable

  include AuthorizedPersona::Persona

  has_many :boards, foreign_key: :author
  has_many :tasks, foreign_key: :creator
  has_many :task_users
  has_many :tasks, through: :task_users

  # authorization_tiers(
  #   user: "User - limited access",
  #   manager: "Manager - manages users and boards",
  #   admin: "Admin - total access"
  # )

  # validates :authorization_tier, inclusion: { in: authorization_tier_names }

  def full_name
    first_name + ' ' + last_name
  end

  def user_on_task?(id)
    !tasks.find_by_id(id).nil?
  end
end
