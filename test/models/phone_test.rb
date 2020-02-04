require 'test_helper'
require 'minitest/spec'

describe Phone do
	describe "validity" do
		it "should fail - the number is blank" do 
			assert_equal(["Number can't be blank"], 
			Phone.create(client_id:1).errors.full_messages)
		end
		it "should fail - the client is blank" do 
			assert_equal(["Client must exist"], 
			Phone.create(number:1230).errors.full_messages)
		end
		it "should fail - the client not exist" do 
			assert_equal(["Client must exist"], 
			Phone.create(number:1230, client_id:333).errors.full_messages)
		end
		it "should pass - everything is OK" do
			assert(true, Phone.create(number:123340, client_id:1).valid?)
		end
	end
end