class SellsController < ApplicationController
	before_action :validate_user

	def all
		@sells = Sell.joins(:client).select(:id, :created_at, :name).where(user_id: @user.id)

		render json: SellSerializer.new(@sells, {fields: {sell: [:name, :created_at, :total_amount]}})
	end

	def searchOne
		id = params[:id]
		incl = params[:include]
		@sell = Sell.find_by(id: id)
		options = {}
		
		if @sell && (@sell.user_id == @user.id)
			@sell = Sell.joins(:client).select(:id, :created_at, :name).where(id: id)
			if not incl.nil?
  				options[:include] = incl.split(',')
  			end
  			render json: SellSerializer.new(@sell,options).serializable_hash
		else
			render :status => 404
		end
	end

	def createOne
		user_id = @user.id
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
			sell = Sell.create(user_id: user_id, client_id: client_id, total_amount: total_a)
			for i in products
				prod = Product.find_by(code: i["code"])
				items = Item.where(product_id: prod.id, status: 0).limit(i["cant"]).update(status: 2, sell_id: sell.id, amount: prod.unit_amount)
				items.map { |each| total_a = total_a + each.amount  }
				stock_act = prod.stock 
				prod.update(stock: stock_act - i["cant"])
				sell.update(total_amount: total_a)
			end
			render json: sell
		else
			render json: errors, status: 404
		end
	end

	def validate_user
    	@user = User.find_by(authentication_token: request.headers["Authorization"])
    	user = @user
    	if @user.blank?  
    		render :status => 401
    	elsif (not (user.token_created_at + 30.minutes) > (Time.now.utc))
    		@user.update(token_created_at: nil, authentication_token: "blank")
    		render :status => 401
    	end
    end

    def checkClientBlank(client_id)
		c = Client.where(id:client_id)
		c.blank?
	end
end
