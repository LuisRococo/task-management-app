# frozen_string_literal: true

class TaskRecordDynamicDate < ActiveRecord::Migration[6.1]
  def up
    change_column_default :task_change_records, :date, -> { 'CURRENT_TIMESTAMP' }
  end

  def down
    change_column_default :task_change_records, :date, DateTime.now
  end
end
