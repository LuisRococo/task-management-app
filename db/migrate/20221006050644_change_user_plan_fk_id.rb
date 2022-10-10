# frozen_string_literal: true

class ChangeUserPlanFkId < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :plans_id, :plan_id
  end
end
