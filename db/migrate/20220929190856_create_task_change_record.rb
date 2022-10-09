# frozen_string_literal: true

class CreateTaskChangeRecord < ActiveRecord::Migration[6.1]
  def change
    create_table :task_change_records do |t|
      t.references :tasks
      t.string :new_list
      t.datetime :date, default: DateTime.new
    end
  end
end
