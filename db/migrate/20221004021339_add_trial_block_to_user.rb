# frozen_string_literal: true

class AddTrialBlockToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :trial_block, :bool
  end
end
