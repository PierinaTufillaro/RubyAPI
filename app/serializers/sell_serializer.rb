class SellSerializer
  include FastJsonapi::ObjectSerializer
  has_many :items
  attributes :name, :created_at
 
  attributes :total_amount do |object|
  	object.items.sum(:amount)
  end
end
