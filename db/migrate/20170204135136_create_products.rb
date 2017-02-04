class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :upc
      t.string :title
      t.float :original_price
      t.text :description

      t.timestamps null: false
    end
  end
end
