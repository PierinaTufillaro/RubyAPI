class SessionController < ApplicationController

	def create
		@user = User.find_by(email: params[:email])
		
		if @user.present? && @user.valid_password?(params[:password].to_s)
			@user.update(authentication_token: generate_access_token, token_created_at: Time.now.utc)
			render json: @user.as_json(only: [:email, :authentication_token]), status: :created
			#render json: 
		else
			head(:unauthorized)
		end
	end

	def createUser
		@email = params[:email]
		@password = params[:password]		
		@user = User.find_by(email: @email)	
		if User.create(email:@email, password:@password).valid?
			render json: "ok"
		else
			render :status => 404
		end
	end

    def generate_access_token
      loop do
        token = Devise.friendly_token
        break token unless User.where(authentication_token: token).first
      end
    end
end