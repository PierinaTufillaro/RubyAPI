require 'test_helper'
require 'minitest/spec'

describe Client do
	describe "validity" do
		it "should fail - the cuit_cuil is blank" do 
			cl = Client.new(name:"Jose",email:"jose1212@mail.com",iva_cond:1)
			cl.phones.new(number:"12345")
			assert_equal(false, cl.save)
		end
		it "should fail - the name is blank" do 
			cl = Client.new(cuit_cuil:"12345678",email:"jose1212@mail.com",iva_cond:1)
			cl.phones.new(number:"12345")
			assert_equal(false, cl.save)
		end
		it "should fail - the email is blank" do 
			cl = Client.new(cuit_cuil:"12345678",name:"Jose",iva_cond:1)
			cl.phones.new(number:"12345")
			assert_equal(false, cl.save)
		end
		it "should fail - the iva_cond is blank" do 
			cl = Client.create(cuit_cuil:"343434/6",name:"Jose",email:"jose@mail.com")
			cl.phones.new(number:"12345")
			assert_equal(false, cl.save)  
		end
		it "should fail - the iva_cond not exists" do 
			assert_raises(ArgumentError) { Client.create(cuit_cuil:"343434/6",name:"Jose",email:"jose@mail.com",iva_cond:0) }
		end
		it "should fail - the cuit_cuil exists" do
			cl = Client.create(cuit_cuil:"123456",name:"Jose",email:"jose@mail.com")
			cl.phones.new(number:"12345")
			assert_equal(false, cl.save) 
		end
		it "should fail - the email exists" do
			cl = Client.create(cuit_cuil:"99900/6",name:"Jose",email:"test@mail.com",iva_cond:1)
			cl.phones.new(number:"12345")
			assert_equal(false, cl.save) 
			
		end
		it "should fail - the client has no phone" do 
			cl = Client.new(cuit_cuil:"343434/6",name:"Jose",email:"jose@mail.com",iva_cond:1)
			assert_equal(false, cl.save) 
		end
		it "should pass - everything is OK" do
			cl = Client.create(cuit_cuil:"343434/6",name:"Jose",email:"jose@mail.com",iva_cond:1)
			cl.phones.new(number:"123456") 
			assert(true, cl.save)
		end
	end
end
