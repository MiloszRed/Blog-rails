class RegistrationsController < Devise::RegistrationsController
    #private
    respond_to :json
    skip_before_action :authenticate_scope!
    before_action :configure_permitted_parameters

    def new
        super
    end

    def create
        user = User.new(sign_up_params)
      
        if user.save
            token = user.generate_jwt
            refresh_token = user.refresh_tokens.create!
            cookies.signed[:token] = {value: token, httponly: true}
            cookies.signed[:refresh_token] = {value: refresh_token.crypted_token, httponly: true}
            render json: { admin: false, signedIn: true, userId: user.id }
        else
            render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
        end
    end

    def update    
        user = User.find(account_update_params[:user_id])
      
        if user && user.valid_password?(account_update_params[:current_password])
          user.reset_password(account_update_params[:password], account_update_params[:password_confrimation])
          render json: { admin: user.admin, signedIn: true, userId: user.id }
        else
          render json: { errors: { 'err' => 'Email or password is invalid' } }, status: :unprocessable_entity
        end
    end

    def destroy   
        current_user.destroy!

        cookies.delete(:token)
        cookies.delete(:refresh_token)

        head :ok
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:account_update, keys: [:user_id, :password, :password_confrimation, :current_password])
        devise_parameter_sanitizer.permit(:user, keys: [:user_id])
    end
end