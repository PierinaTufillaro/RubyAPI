# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
 User.find_or_create_by!(email:"admin98@admin.com"){|u| u.update(password: "12345678")}
 Client.find_or_create_by!(cuit_cuil:"123456/6", name:"Pierina", email:"pierinaTufillaro98@email.com", iva_cond: 1)
 p = Product.find_or_create_by!(code:"PPP444", short_description:"Bebida", long_description: "Gaseosa Cola", 
 	unit_amount: 10, stock:2)
 Item.create!(status:0, product: p)
 Item.create!(status:0, product: p)

