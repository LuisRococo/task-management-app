class Board < ApplicationRecord
  @@TASK_LIST_LIMIT = 50
  belongs_to :author, class_name: 'User'
  has_many :task_lists, dependent: :destroy

  def user_has_access?(user)
    manager = user.authorization_tier == 'user' ? user.manager : user
    manager == author
  end

  def self.TASK_LIST_LIMIT
    @@TASK_LIST_LIMIT
  end

  def max_task_lists_reached?
    task_lists.count >= @@TASK_LIST_LIMIT
  end
end
