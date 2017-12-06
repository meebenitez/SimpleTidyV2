class CreateListsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :lists_users do |t|
      t.integer :user_id
      t.integer :list_id

      t.timestamps
    end
  end
end
