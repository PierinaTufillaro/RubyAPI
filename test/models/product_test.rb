require 'test_helper'
require 'minitest/spec'

describe Product do
	describe "validity" do
		it "should fail - the code is blank" do 
			assert_equal("Code can't be blank", 
			Product.create(short_description: "Water", long_description: "1,5L", unit_amount: 20).errors.full_messages[0])
		end
		it "should fail - the short_description is blank" do 
			assert_equal("Short description can't be blank", 
			Product.create(code: "PPP333", long_description: "1,5L", unit_amount: 20).errors.full_messages[0])
		end
		it "should fail - the long_description is blank" do 
			assert_equal("Long description can't be blank", 
			Product.create(code: "PPP333",short_description: "Water",unit_amount: 20).errors.full_messages[0])
		end
		it "should fail - the unit_amount is blank" do 
			assert_equal("Unit amount can't be blank", 
			Product.create(code: "PPP333",short_description: "Water",long_description: "1,5L").errors.full_messages[0])
		end
		it "should fail - the code exists" do 
			assert_equal("Code has already been taken", 
			Product.create(code: "PPP111",short_description: "Water", long_description: "1,5L", unit_amount: 20).errors.full_messages[0])
		end
		it "should fail - the code has less than 6 characters" do
			assert_equal(["Code is the wrong length (should be 6 characters)"], 
			Product.create(code: "PPP33",short_description: "Water", long_description: "1,5L", unit_amount: 20).errors.full_messages)
		end
		it "should pass - the items were deleted" do
			prod = Product.create(code: "PPP333",short_description: "Water", long_description: "1,5L", unit_amount: 20)
			Item.create(product_id: "PPP333", status: 0)
			prod.delete
			assert_equal(0, Item.where(product_id:"PPP333").length)
		end
	end
end
