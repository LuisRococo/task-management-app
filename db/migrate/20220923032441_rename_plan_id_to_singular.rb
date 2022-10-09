# frozen_string_literal: true

class RenamePlanIdToSingular < ActiveRecord::Migration[6.1]
  def change
    rename_column :plans, :plans_id, :plan_id

    reversible do |change|
      change.up do
        query = 'ALTER SEQUENCE plans_plans_id_seq RENAME TO plans_plan_id_seq;'
        ActiveRecord::Base.connection.execute(query)
      end

      change.down do
        query = 'ALTER SEQUENCE plans_plan_id_seq RENAME TO plans_plans_id_seq;'
        ActiveRecord::Base.connection.execute(query)
      end
    end
  end
end
