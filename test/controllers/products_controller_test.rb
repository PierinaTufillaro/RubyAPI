require 'test_helper'
require 'minitest/autorun'
require 'minitest/spec'

class ProductsControllerTests < ActionDispatch::IntegrationTest
	#before do
	# 	User.create(email:"trying@email.com", password:"12345678", authentication_token:"Ingreso")
	#end
	#setup :createSession
 	test "All - should pass" do
 		token = User.find_by(id: 3).authentication_token
		get 'http://localhost:3000/products/all', headers: {Authorization: token} 
		assert_response :success
 	end
 	test "Scarce - should pass" do
		token = User.find_by(id: 3).authentication_token
		get 'http://localhost:3000/products/scarce', headers: {Authorization: token} 
		assert_response :success
 	end
 	test "In stock - should pass" do
		token = User.find_by(id: 3).authentication_token
		get 'http://localhost:3000/products', headers: {Authorization: token} 
		assert_response :success
 	end
 	test "SearchOne - should pass - product NOT exist" do
		token = User.find_by(id: 3).authentication_token
		get 'http://localhost:3000/products/PPP333', headers: {Authorization: token} 
		assert_response :missing
 	end
 	test "SearchOne - should pass - product exist" do
		token = User.find_by(id: 3).authentication_token
		get 'http://localhost:3000/products/PPP111', headers: {Authorization: token} 
		assert_response :success
 	end
 	test "SearchItems - should pass" do
		token = User.find_by(id: 3).authentication_token
		get 'http://localhost:3000/products/PPP111/items', headers: {Authorization: token} 
		assert_response :success
 	end
 	test "SumItems - should pass" do
		token = User.find_by(id: 3).authentication_token
		assert_difference('Item.where(product_id:1).count', +2) do
			post 'http://localhost:3000/products/PPP111/items', 
			params: {items: 2}, headers: {Authorization: token} 
		end
 	end
end
