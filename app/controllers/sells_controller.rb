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
end
