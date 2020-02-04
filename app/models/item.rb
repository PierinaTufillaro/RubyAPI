class Item < ApplicationRecord
	enum status: {disponible: 0, reservado: 1, vendido: 2}
	validates :status, inclusion: { in: statuses.keys}
	belongs_to :reservation, optional: true
	belongs_to :sell, optional: true
	belongs_to :product
end
