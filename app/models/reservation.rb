class Reservation < ApplicationRecord
	has_many :items
	has_many :products, through: :items
	has_one :sell
	belongs_to :client
	belongs_to :user
end
