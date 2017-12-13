class CreateInvites < ActiveRecord::Migration[5.1]
  def change
    create_table :invites do |t|
      t.string :status, :default => "open"
      t.datetime :exp_date
      t.string :email
      t.integer :list_id
      t.integer :user_id

      t.timestamps
    end
  end
end
