class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :upc, null: false, uniq: true
      t.string :title, null: false
      t.float :original_price, null: false
      t.text :description, null: false

      t.timestamps null: false
    end
  end
end
