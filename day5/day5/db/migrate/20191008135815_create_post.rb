class CreatePost < ActiveRecord::Migration[5.2]
  def change
     create_table :posts do |t|
      t.references :category
      t.references :user
      t.text :comment
      t.string :title
      t.string :creator
      t.string :publisher
      t.string :publicname
      t.string :volume
      t.string :number
      t.string :startingpage
      t.string :endingpage
      t.string :date
      t.timestamps null: false
    end
  end
end
