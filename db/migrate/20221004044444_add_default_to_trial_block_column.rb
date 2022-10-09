# frozen_string_literal: true

class AddDefaultToTrialBlockColumn < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:users, :trial_block, from: nil, to: false)
  end
end
