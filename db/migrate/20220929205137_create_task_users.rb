class CreateTaskUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :task_users do |t|
      t.references :task
      t.references :user
      t.timestamps
    end
  end
end
