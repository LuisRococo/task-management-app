class AddAuthorizationTierToUser < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.string :authorization_tier
    end
  end
end
