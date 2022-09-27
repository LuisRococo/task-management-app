class CreateTask < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.references :creator, foreign_key: { to_table: :users }
      t.datetime :started_at
      t.datetime :finished_at
      t.integer :doing_time
      t.string :justification
      t.references :task_list
      t.timestamps
    end
  end
end
