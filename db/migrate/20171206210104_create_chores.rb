class CreateChores < ActiveRecord::Migration[5.1]
  def change
    create_table :chores do |t|
      t.string :name
      t.string :frequency
      t.string :time_of_day, :default => nil
      t.string :status, :default => "not done"
      t.boolean :past_due, :default => false
      t.integer :list_id
      t.datetime :reset_time

      t.timestamps
    end
  end
end
