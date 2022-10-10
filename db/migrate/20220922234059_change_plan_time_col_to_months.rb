# frozen_string_literal: true

class ChangePlanTimeColToMonths < ActiveRecord::Migration[6.1]
  def change
    rename_column :plans, :time_milliseconds, :time_months
  end
end
