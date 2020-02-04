require 'test_helper'
require 'minitest/autorun'
require 'minitest/spec'

class ReservationsControllerTest < ActionDispatch::IntegrationTest
 	test "All - should pass" do
		get 'http://localhost:3000/reservations'
		assert_response :success
 	end
 	test "SearchOne - should fail - reservation NOT exists" do
		get 'http://localhost:3000/reservations/3'
		assert_response :missing
 	end
 	test "SearchOne - should pass - reservation exists" do
		get 'http://localhost:3000/reservations/1'
		assert_response :success
 	end
 	test "SellOne - should pass - reservation NOT exists" do
		put 'http://localhost:3000/reservations/3/sell'
		assert_response :missing
 	end
 	test "SellOne - should fail - reservation exists and SOLD" do
		put 'http://localhost:3000/reservations/1/sell'
		assert_response :missing
 	end
 	test "SellOne - should pass - reservation exists and NOT sold" do
		put 'http://localhost:3000/reservations/2/sell'
		assert_response :success
 	end
 	test "Delete - should fail - reservation NOT exists" do
		delete 'http://localhost:3000/reservations/3'
		assert_response :missing
 	end
 	test "Delete - should fail - reservation exists and SOLD" do
		delete 'http://localhost:3000/reservations/1'
		assert_response :missing
 	end
 	test "Delete - should pass - reservation exists and NOT sold" do
		assert_difference('Reservation.count', -1) do
			delete 'http://localhost:3000/reservations/2'
		end
 	end
end
