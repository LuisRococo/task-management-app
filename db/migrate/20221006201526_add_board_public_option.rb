class AddBoardPublicOption < ActiveRecord::Migration[6.1]
  def change
    add_column :boards, :is_public, :bool, default: false
  end
end
