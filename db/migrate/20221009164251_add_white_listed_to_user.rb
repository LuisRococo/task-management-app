class AddWhiteListedToUser < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.boolean :white_listed, default: false
    end
  end
end
