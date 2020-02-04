require 'test_helper'
require 'minitest/spec'

describe Client do
	describe "validity" do
		it "should fail - the cuit_cuil is blank" do 
			assert_equal(["Cuit cuil can't be blank"], 
			Client.create(name:"Jose",email:"jose1212@mail.com",iva_cond:1).errors.full_messages)
		end
		it "should fail - the name is blank" do 
			assert_equal(["Name can't be blank"], 
			Client.create(cuit_cuil:"1212212/6",email:"jose22@mail.com",iva_cond:1).errors.full_messages)
		end
		it "should fail - the email is blank" do 
			assert_equal(["Email can't be blank"], 
			Client.create(cuit_cuil:"1212212/6",name:"Jose",iva_cond:1).errors.full_messages)
		end
		it "should fail - the iva_cond is blank" do 
			assert_equal(false, Client.create(cuit_cuil:"343434/6",name:"Jose",email:"jose@mail.com").valid?)  
		end
		it "should fail - the iva_cond not exists" do 
			assert_raises(ArgumentError) { Client.create(cuit_cuil:"343434/6",name:"Jose",email:"jose@mail.com",iva_cond:0) }
		end
		it "should fail - the cuit_cuil exists" do
			assert_equal(["Cuit cuil has already been taken"], 
			Client.create(cuit_cuil:"123456",name:"Jose",email:"jose12@mail.com",iva_cond:1).errors.full_messages)
		end
		it "should fail - the email exists" do
			assert_equal(["Email has already been taken"], 
			Client.create(cuit_cuil:"12122555/6",name:"Jose",email:"test@mail.com",iva_cond:1).errors.full_messages)
		end
		#it "should fail - the client has no phone" do 
		#	
		#end
		it "should pass - everything is OK" do
			assert(true, Client.create(cuit_cuil:"343434/6",name:"Jose",email:"jose@mail.com",iva_cond:1).valid?)
		end
	end
end
