class SessionsController < Devise::SessionsController
    #private
    respond_to :json
    skip_before_action :verify_signed_out_user

    def create
        user = User.find_by_email(sign_in_params[:email])
      
        if user && user.valid_password?(sign_in_params[:password])
          token = user.generate_jwt
          refresh_token = user.refresh_tokens.create!
          cookies.signed[:token] = {value: token, httponly: true}
          cookies.signed[:refresh_token] = {value: refresh_token.crypted_token, httponly: true}
          render json: { admin: user.admin, signedIn: true, userId: user.id }
        else
          render json: { errors: { 'err' => 'Email or password is invalid' } }, status: :unprocessable_entity
        end
    end

    def destroy
      cookies.delete(:token)
      cookies.delete(:refresh_token)
    end

    def respond_to_on_destroy
      head :ok
    end
end