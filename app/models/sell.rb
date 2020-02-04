class Sell < ApplicationRecord
	has_many :items
	has_many :products, through: :items
	belongs_to :reservation, optional: true
	belongs_to :client
	belongs_to :user
end
