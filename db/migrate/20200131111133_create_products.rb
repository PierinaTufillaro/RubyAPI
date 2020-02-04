class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :code, null: false
      t.string :short_description, null: false
      t.string :long_description, null: false
      t.decimal :unit_amount, null: false
      t.integer :stock
      
      t.timestamps
    end
  end
end