class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.integer :status, null: false
      t.belongs_to :product, foreing_key: true
      t.belongs_to :reservation, foreing_key: true
      t.belongs_to :sell, foreing_key: true
      t.decimal :amount

      t.timestamps
    end
  end
end
