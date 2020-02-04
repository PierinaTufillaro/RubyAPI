class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.boolean :sold, default: false
      t.decimal :total_amount
      t.belongs_to :user, foreing_key: true
      t.belongs_to :client, foreing_key: true
      
      t.timestamps
    end
  end
end
