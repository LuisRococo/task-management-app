# frozen_string_literal: true

class TaskAddCompleted < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :completed, :bool
  end
end
