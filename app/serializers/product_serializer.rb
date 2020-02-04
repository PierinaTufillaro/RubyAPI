class ProductSerializer
  include FastJsonapi::ObjectSerializer
  attributes :code, :short_description, :long_description, :unit_amount, :stock, :created_at, :updated_at
  has_many :items

  attributes :stock do |object|
  	object.items.where(status: 0).length
  end
end
