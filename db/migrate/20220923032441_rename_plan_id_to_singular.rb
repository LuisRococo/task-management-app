class RenamePlanIdToSingular < ActiveRecord::Migration[6.1]
  def change
    rename_column :plans, :plans_id, :plan_id
  end
end
