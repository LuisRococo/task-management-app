# frozen_string_literal: true

class AddDefaultToPayBlockColumn < ActiveRecord::Migration[6.1]
  def up
    remove_column :users, :pay_block
    add_column :users, :pay_block, :bool, default: false
  end

  def down
    remove_column :users, :pay_block
    add_column :users, :pay_block, :datetime
  end
end
