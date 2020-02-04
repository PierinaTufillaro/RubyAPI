class ReservationSerializer
  include FastJsonapi::ObjectSerializer
  has_many :items
  has_one :sell
  attributes :name, :created_at
 
  attributes :total_amount do |object|
  	object.items.sum(:amount)
  end
end