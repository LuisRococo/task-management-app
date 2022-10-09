# frozen_string_literal: true

class TaskUser < ApplicationRecord
  belongs_to :task
  belongs_to :user
  validates :task_id, uniqueness: { scope: :user_id }

  def self.find_by_user_and_task(user, task)
    find_by(user: user, task: task)
  end
end
