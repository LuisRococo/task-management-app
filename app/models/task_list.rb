# frozen_string_literal: true

class TaskList < ApplicationRecord
  belongs_to :board
  has_many :tasks, dependent: :destroy
  alias_attribute :title, :name
  validate :board_list_capacity

  def board_list_capacity
    if board.max_task_lists_reached?
      errors.add(:board_id, "Board cannot have more than #{Board.TASK_LIST_LIMIT} task lists")
    end
  end
end
