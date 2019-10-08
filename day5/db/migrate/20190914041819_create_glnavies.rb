class CreateGlnavies < ActiveRecord::Migration[5.2]
  def change
     create_table :glnavies do |t|
      t.string :keyid
      t.string :name
      t.float :latitude
      t.float :longitude
      t.integer :range
      t.string :freeword
      t.integer :no_smoking
      t.integer :card
    end
  end
end
