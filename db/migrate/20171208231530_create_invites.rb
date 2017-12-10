class CreateInvites < ActiveRecord::Migration[5.1]
  def change
    create_table :invites do |t|
      t.boolean :accepted
      t.datetime :exp_date
      t.string :email
      t.string :invite_code
      t.integer :list_id
      t.integer :user_id

      t.timestamps
    end
  end
end
