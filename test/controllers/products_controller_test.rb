require 'test_helper'
require 'minitest/autorun'
require 'minitest/spec'

class ProductsControllerTests < ActionDispatch::IntegrationTest
	before do
		
	end
 	test "All - should pass" do
		get 'http://localhost:3000/products/all'
		assert_response :success
 	end
 	test "Scarce - should pass" do
		get 'http://localhost:3000/products/scarce'
		assert_response :success
 	end
 	test "In stock - should pass" do
		get 'http://localhost:3000/products'
		assert_response :success
 	end
 	test "SearchOne - should pass - product NOT exist" do
		get 'http://localhost:3000/products/PPP333'
		assert_response :missing
 	end
 	test "SearchOne - should pass - product exist" do
		get 'http://localhost:3000/products/PPP111'
		assert_response :success
 	end
 	test "SearchItems - should pass" do
		get 'http://localhost:3000/products/PPP111/items'
		assert_response :success
 	end
 	test "SumItems - should pass" do
		assert_difference('Item.where(product_id:1).count', +2) do
			post 'http://localhost:3000/products/PPP111/items', 
			params: {items: 2}, as: :json
		end
 	end
end
