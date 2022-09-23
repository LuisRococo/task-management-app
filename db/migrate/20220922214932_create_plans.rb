class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans, primary_key: :plans_id do |t|
      t.string :title
      t.integer :member_quantity
      t.monetize :price
      t.integer :time_milliseconds
      t.timestamps
    end
  end
end
