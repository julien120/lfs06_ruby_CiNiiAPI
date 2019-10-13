class CreateMiddle < ActiveRecord::Migration[5.2]
  def change
    create_table :middles do |t|
      t.references :post
      t.references :tag
    end
  end
end
