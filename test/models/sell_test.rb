require 'test_helper'
require 'minitest/spec'

describe Sell do
	describe "validity" do
		it "should fail - the client_id is blank" do 
			assert_equal(["Client must exist"], 
			Sell.create(user_id: 1).errors.full_messages)
		end
		it "should fail - the user_id is blank" do 
			assert_equal(["User must exist"], 
			Sell.create(client_id: 1).errors.full_messages)
		end
		it "should fail - the client not exists" do 
			assert_equal(["Client must exist"], 
			Sell.create(user_id: 1, client_id: 33).errors.full_messages)
		end
		it "should fail - the user not exists" do 
			assert_equal(["User must exist"], 
			Sell.create(user_id: 3, client_id: 2).errors.full_messages)
		end
		it "should pass - everything is OK (not contains a reservation)" do
			assert_equal(true, 
			Sell.create(client_id: 1, user_id: 2).valid?)
		end
		it "should pass - everything is OK (contains an existing reservation)" do
			assert_equal(true, 
			Sell.create(client_id: 1, user_id: 1, reservation_id: 1).valid?)
		end
	end
end