class AddDefaultToTrialBlockColumn < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :trial_block, :bool, default: false
  end
end
