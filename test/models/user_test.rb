require 'test_helper'
require 'minitest/spec'

describe User do
	describe "validity" do
		it "should fail - the email is blank" do 
			assert_equal(["Email can't be blank"], 
			User.create(password: "123456789").errors.full_messages)
		end
		it "should fail - the password is blank" do 
			assert_equal("Password can't be blank", 
			User.create(email: "testing2@email.com").errors.full_messages[0])
		end
		it "should fail - the password has less than 6 characters" do
			assert_equal(["Password is too short (minimum is 6 characters)"], 
			User.create(email: "testing1@email.com", password: "123").errors.full_messages)
		end
		it "should fail - the email exists" do
			assert_equal(["Email has already been taken"], 
			User.create(email: "Pierina@email.com", password: "12345678").errors.full_messages)
		end
		it "should pass - everything is OK" do
			assert(true, User.create(email: "testing@email.com", password: "12345678").valid?)
		end
	end
end