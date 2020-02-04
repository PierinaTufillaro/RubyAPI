class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :status, :product_id, :reservation_id, :sell_id, :amount, :created_at, :updated_at
end
