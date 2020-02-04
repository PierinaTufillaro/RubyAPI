class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :cuit_cuil, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.integer :iva_cond, null: false

      t.timestamps
    end
  end
end