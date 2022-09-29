class FixTaskChangeRecord < ActiveRecord::Migration[6.1]
  def up
    rename_column :task_change_records, :tasks_id, :task_id
    change_column_default :task_change_records, :date, DateTime.now
  end

  def down
    rename_column :task_change_records, :task_id, :tasks_id
    change_column_default :task_change_records, :date, DateTime.new
  end
end
