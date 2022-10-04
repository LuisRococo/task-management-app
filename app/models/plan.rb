class Plan < ApplicationRecord
  default_scope { order(:plan_id) }
  monetize :price_cents
  has_many :users
end
