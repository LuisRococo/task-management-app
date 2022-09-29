class Task < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :task_list
  has_rich_text :content

  def board
    task_list.board
  end
end