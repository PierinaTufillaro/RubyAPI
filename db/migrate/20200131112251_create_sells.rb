class CreateSells < ActiveRecord::Migration[6.0]
  def change
    create_table :sells do |t|
      t.decimal :total_amount
      t.belongs_to :user, foreing_key: true
      t.belongs_to :client, foreing_key: true
      t.belongs_to :reservation, foreing_key: true, optional: true

      t.timestamps
    end
  end
end