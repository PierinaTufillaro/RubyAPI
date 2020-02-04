class ProductsController < ApplicationController
	before_action :validate_user
	
	def all
		@products = Product.all.limit(25) 

		render json: ProductSerializer.new(@products)
	end

	def scarce
		@products = Product.where(stock: 1..5).limit(25) 

		render json: ProductSerializer.new(@products)
	end

	def in_stock
		@products = Product.where("stock > ?", 0).limit(25)
 	
		render json: ProductSerializer.new(@products)
	end


	def searchOne
		@codigo = params[:codigo]

		@products = Product.find_by(code: @codigo)
		if @products
			render json: ProductSerializer.new(@products)
		else
			render :status => 404
		end
	end

	def searchItems
		@codigo = params[:codigo]

		@product = Product.find_by(code: @codigo)

		@items = Item.where(product_id: @product)
		
		render json: ItemSerializer.new(@items)
	end

	def sumItems
		@codigo = params[:codigo]
		@items = params[:items]		
		@product = Product.find_by(code: @codigo)
		
		if @product.nil?
			render :status => 404
		else		
			for i in (1..@items.to_i)
				Item.create(product_id:@product.id, status:0)
				stock = @product.stock
				@product.update(stock: stock + 1)
			end
			@respuesta = "OK"
			render json: @respuesta
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
    	#render json: request.headers["Authorization"]
    end
end


