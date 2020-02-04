class CreatePhones < ActiveRecord::Migration[6.0]
  def change
    create_table :phones do |t|
      t.string :number
      t.belongs_to :client, foreing_key: true
      
      t.timestamps
    end
  end
end
