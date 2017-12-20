class AddAdminIdToLists < ActiveRecord::Migration[5.1]
  def change
    add_column :lists, :creator_id, :integer
  end
end
