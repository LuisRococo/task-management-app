class Plan < ApplicationRecord
  default_scope { order(:plan_id) }
  monetize :price_cents
  has_many :users

  def duration_in_days
    time_months.months.days
  end
end
