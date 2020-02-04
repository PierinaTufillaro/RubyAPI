# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
 User.create!(email:"admin98@admin.com",password:"12345678")
 Client.create!(cuit_cuil:"123456/6", name:"Pierina", email:"pierinaTufillaro98@email.com", iva_cond: 1)
 Product.create!(code:"PPP444", short_description:"Bebida", long_description: "Gaseosa Cola", 
 	unit_amount: 10, stock:2)
 Item.create!(status:0, product_id:1)
 Item.create!(status:0, product_id:1)

