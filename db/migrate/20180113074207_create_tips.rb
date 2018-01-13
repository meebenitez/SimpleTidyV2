class CreateTips < ActiveRecord::Migration[5.1]
  def change
    create_table :tips do |t|
      t.string :title
      t.string :tip
      t.string :source_name
      t.string :source_url

      t.timestamps
    end
  end
end
