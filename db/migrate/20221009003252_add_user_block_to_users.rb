# frozen_string_literal: true

class AddUserBlockToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :user_block, :bool, default: false
  end
end
