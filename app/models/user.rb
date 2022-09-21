class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  include AuthorizedPersona::Persona

  # authorization_tiers(
  #   user: "User - limited access",
  #   manager: "Manager - manages users and boards",
  #   admin: "Admin - total access"
  # )

  # validates :authorization_tier, inclusion: { in: authorization_tier_names }
end
