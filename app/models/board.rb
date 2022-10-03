class Board < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :task_lists, dependent: :destroy

  def user_has_access?(user)
    manager = user.authorization_tier == 'user' ? user.manager : user
    manager == author
  end
end
