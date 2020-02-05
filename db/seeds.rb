# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#Users
usr1 = User.create!(email:"user1@user1.com", password:"i-am-user-1")
usr2 = User.create!(email:"user2@user2.com", password:"i-am-user-2")

#Clients
cl1 = Client.new(cuit_cuil:"111111/1", name:"Client-1", email:"client1@client1.com", iva_cond:4).phones.new(number:"123456")
cl1.save!
cl2 = Client.new(cuit_cuil:"222222/2", name:"Client-2", email:"client2@client2.com", iva_cond:2).phones.new(number:"78910")
cl2.save!
#Reservations
res1 = Reservation.create!(user_id: usr1.id, client_id: cl1.id, total_amount: 30)
res2 = Reservation.create!(user_id: usr2.id, client_id: cl1.id, total_amount: 5)

#Sells
sell1 = Sell.create!(user_id: usr1.id, client_id: cl1.id, total_amount: 20)
sell2 = Sell.create!(user_id: usr2.id, client_id: cl1.id, total_amount: 5)

#Product with items

#Product 1
prod1 = Product.create!(code:"PPP111", short_description:"Bottle of water", long_description:"1,5 L",
	unit_amount: 10, stock: 3)

#Items 1
Item.create!(status:1, product_id: prod1.id, reservation_id: res1.id)
Item.create!(status:2, product_id: prod1.id, sell_id: sell1.id)
Item.create!(status:2, product_id: prod1.id, sell_id: sell1.id)
Item.create!(status:0, product_id: prod1.id)
Item.create!(status:0, product_id: prod1.id)
Item.create!(status:0, product_id: prod1.id)

#Product 2
prod2 = Product.create!(code:"PPP222", short_description:"Bottle of wine", long_description:"1 L",
	unit_amount: 20, stock: 2)

#Items 2
Item.create!(status:1, product_id: prod2.id, reservation_id: res1.id)
Item.create!(status:0, product_id: prod2.id)
Item.create!(status:0, product_id: prod2.id)

#Product 3
prod3 = Product.create!(code:"PPP333", short_description:"Bottle of Coca-Cola", long_description:"3 L",
	unit_amount: 25, stock: 0)

#Items 3

#Product 4
prod4 = Product.create!(code:"PPP444", short_description:"Pringles", long_description:"Chips",
	unit_amount: 5, stock: 6)

#Items 4
Item.create!(status:1, product_id: prod4.id, reservation_id: res2.id)
Item.create!(status:2, product_id: prod4.id, sell_id: sell2.id)
Item.create!(status:0, product_id: prod4.id)
Item.create!(status:0, product_id: prod4.id)
Item.create!(status:0, product_id: prod4.id)
Item.create!(status:0, product_id: prod4.id)
Item.create!(status:0, product_id: prod4.id)
Item.create!(status:0, product_id: prod4.id)



