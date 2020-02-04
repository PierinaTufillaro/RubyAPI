class Phone < ApplicationRecord
	validates :number, presence: true, null: false
	belongs_to :client
end
