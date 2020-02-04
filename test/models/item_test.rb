require 'test_helper'
require 'minitest/spec'

describe Item do
	describe "validity" do
		it "should fail - the product is blank" do 
			assert_equal(["Product must exist"], 
			Item.create(status:0).errors.full_messages)
		end
		it "should fail - the product not exist" do 
			assert_equal(["Product must exist"], 
			Item.create(status:0, product_id: 3).errors.full_messages)
		end
		it "should fail - the status is blank" do 
			assert_equal(false, Item.create(product_id: 1).valid?)
		end
		it "should fail - the status not exist" do 
			assert_raises(ArgumentError) {Item.create(product_id: 1, status: 4)}
		end
		it "should pass - everything is OK" do
			assert(true, Item.create(status:0, product_id: 1).valid?)
		end
	end
end