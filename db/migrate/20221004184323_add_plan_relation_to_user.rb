class AddPlanRelationToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :paid_date, :datetime
    add_column :users, :pay_block, :datetime
    add_reference :users, :plans
  end
end
