class ReservationsController < ApplicationController
	#before_action :validate_user

	def all
		@reservations = Reservation.joins(:client).select(:id, :created_at, :name).where(sold: false)

		render json: ReservationSerializer.new(@reservations, {fields: {reservation: [:name, :created_at, :total_amount]}})
	end

	def searchOne
		@id = params[:id]
		incl = params[:include]
		@reservation = Reservation.joins(:client).select(:id, :created_at, :name).find_by(id: @id)
		options = {}
		
		if @reservation
			if not incl.nil?
  				options[:include] = incl.split(',')
  			end
  			render json: ReservationSerializer.new(@reservation,options).serializable_hash
		else
			render :status => 404
		end
	end

	def createOne
		user_id = params[:user_id]
		client_id = params[:client_id]
		products = params[:products]
		total_a = 0
		errors =[]
		if checkClientBlank(client_id)
			errors << "Error: Client id is empty"
		end
 		if products.blank?
			errors << "Error: Products is empty"
		else
			for i in products
				prod = Product.find_by(code: i["code"])
				if i["code"].blank? || i["cant"].blank?
					errors << "Code and cant can't be blank"
				elsif prod.blank?
					errors << "Code #{i["code"]} not exist"
				elsif i["cant"] < 0
					errors << "The cant for code: #{i["code"]} must be a positive number"
				elsif (prod["stock"] == 0) || (i["cant"] > prod["stock"])
					errors << "The product with code #{i["code"]} has only #{prod.stock} available"
				end
			end
		end
		if errors.blank?
			res = Reservation.create(user_id: user_id, client_id: client_id, total_amount: total_a)
			for i in products
				prod = Product.find_by(code: i["code"])
				items = Item.where(product_id: prod.id, status: 0).limit(i["cant"]).update(status: 1, reservation_id: res.id)
				items.map { |each| total_a = total_a + each.amount  }
				stock_act = prod.stock 
				prod.update(stock: stock_act - i["cant"])
				res.update(total_amount: total_a)
			end
			render json: res
		else
			render json: errors, status: 404
		end
	end

	def sellOne
		@id = params[:id]
		@reservation = Reservation.find_by(id: @id)

		if @reservation.nil? || @reservation.sold 
			render :status => 404
		else
			@reservation.update(sold: true)
			@sell = Sell.create(client_id: @reservation.client_id, user_id: @reservation.user_id, reservation_id: @reservation.id, total_amount: @reservation.total_amount)
			@items = Item.where(reservation_id: @reservation.id)
			@items.map { |each| each.update(sell_id: @sell.id, status: 2)}
		end
	end

	def delete
		@id = params[:id]
		@reservation = Reservation.find_by(id: @id)

		if @reservation.nil? || @reservation.sold 
			render :status => 404
		else
			@items = Item.where(reservation_id: @reservation.id)
			@items.map do 
				|each| each.update(reservation_id: nil, status: 0)
				@pr = Product.where(id: each.product_id)
				stock_p = @pr.stock
				@pr.update(stock: stock_p +1)
			end
			@reservation.delete
		end
	end

	def validate_user
    	@user = User.find_by(authentication_token: params[:token].to_s)
    	user = @user
    	if @user.blank?  
    		render :status => 401
    	elsif (not (user.token_created_at + 30.minutes) > (Time.now.utc))
    		@user.update(token_created_at: nil, authentication_token: "blank")
    		render :status => 401
    	end
    end

    private 

    def checkClientBlank(client_id)
		c = Client.where(id:client_id)
		c.blank?
	end
end
