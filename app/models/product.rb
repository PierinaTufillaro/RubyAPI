class Product < ApplicationRecord
	validates :code, presence: true, null: false, length: { is: 6 }, uniqueness: true
	validates :short_description, presence: true, null: false, length: { in: 1..200 }
	validates :long_description, presence: true, null: false, length: { in: 1..1500 }
	validates :unit_amount, presence: true, null: false
	has_many :items, dependent: :destroy
end
