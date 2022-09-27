class CreateBoard < ActiveRecord::Migration[6.1]
  def change
    create_table :boards do |t|
      t.string :title
      t.references :author, index: true, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
