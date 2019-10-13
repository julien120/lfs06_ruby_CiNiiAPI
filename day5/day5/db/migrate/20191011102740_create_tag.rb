class CreateTag < ActiveRecord::Migration[5.2]
  def change
      create_table :tags do |t|
      t.string :bookshelfname
      t.references :user
      t.timestamps null: false
    end
  end
end
