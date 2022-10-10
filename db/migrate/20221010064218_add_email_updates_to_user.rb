class AddEmailUpdatesToUser < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.boolean :board_update_notification, default: false
      t.boolean :board_delete_notification, default: true
      t.boolean :board_create_notification, default: false
    end
  end
end
