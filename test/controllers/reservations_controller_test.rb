require 'test_helper'
require 'minitest/autorun'
require 'minitest/spec'

class ReservationsControllerTest < ActionDispatch::IntegrationTest
 	test "All - should pass" do
 		token = User.find_by(id: 3).authentication_token
		get 'http://localhost:3000/reservations', headers: {Authorization: token} 
		assert_response :success
 	end
 	test "SearchOne - should fail - reservation NOT exists" do
 		token = User.find_by(id: 3).authentication_token
		get 'http://localhost:3000/reservations/3', headers: {Authorization: token} 
		assert_response :missing
 	end
 	test "SearchOne - should pass - reservation exists" do
 		token = User.find_by(id: 3).authentication_token
		get 'http://localhost:3000/reservations/2', headers: {Authorization: token} 
		assert_response :success
 	end
 	test "SellOne - should pass - reservation NOT exists" do
 		token = User.find_by(id: 3).authentication_token
		put 'http://localhost:3000/reservations/3/sell', headers: {Authorization: token} 
		assert_response :missing
 	end
 	test "SellOne - should fail - reservation exists and SOLD" do
 		token = User.find_by(id: 3).authentication_token
		put 'http://localhost:3000/reservations/1/sell', headers: {Authorization: token} 
		assert_response :missing
 	end
 	test "SellOne - should pass - reservation exists and NOT sold" do
 		token = User.find_by(id: 3).authentication_token
		put 'http://localhost:3000/reservations/2/sell', headers: {Authorization: token} 
		assert_response :success
 	end
 	test "Delete - should fail - reservation NOT exists" do
 		token = User.find_by(id: 3).authentication_token
		delete 'http://localhost:3000/reservations/3', headers: {Authorization: token} 
		assert_response :missing
 	end
 	test "Delete - should fail - reservation exists and SOLD" do
 		token = User.find_by(id: 3).authentication_token
		delete 'http://localhost:3000/reservations/1', headers: {Authorization: token} 
		assert_response :missing
 	end
 	test "Delete - should pass - reservation exists and NOT sold" do
 		token = User.find_by(id: 3).authentication_token
		assert_difference('Reservation.count', -1) do
			delete 'http://localhost:3000/reservations/2', headers: {Authorization: token} 
		end
 	end
end
