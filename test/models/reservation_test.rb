require 'test_helper'
require 'minitest/spec'

describe Reservation do
	describe "validity" do
		it "should fail - the client_id is blank" do 
			assert_equal(["Client must exist"], 
			Reservation.create(user_id: 1).errors.full_messages)
		end
		it "should fail - the user_id is blank" do 
			assert_equal(["User must exist"], 
			Reservation.create(client_id: 1).errors.full_messages)
		end
		it "should fail - the client not exists" do 
			assert_equal(["Client must exist"], 
			Reservation.create(user_id: 1, client_id: 12).errors.full_messages)
		end
		it "should fail - the user not exists" do 
			assert_equal(["User must exist"], 
			Reservation.create(user_id: 3, client_id: 2).errors.full_messages)
		end
		it "should pass - everything is OK" do
			assert_equal(true, 
			Reservation.create(client_id: 1, user_id: 1).valid?)
		end
	end
end