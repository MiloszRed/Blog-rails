class ApplicationController < ActionController::API
    respond_to :json
    before_action :process_token

    include Pundit
    include ::ActionController::Cookies

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def process_token
        if cookies.signed[:token]
            begin
                begin
                    jwt_payload = JWT.decode(cookies.signed[:token], Rails.application.secrets.secret_key_base).first
                    @current_user_id = jwt_payload['id']
                rescue JWT::ExpiredSignature
                    begin
                        jwt_payload = JWT.decode(cookies.signed[:token], Rails.application.secrets.secret_key_base, true, { verify_expiration: false }).first
                        user = User.find(jwt_payload['id'])

                        puts cookies.signed[:refresh_token]
                        
                        refresh_payload = JWT.decode(cookies.signed[:refresh_token], Rails.application.secrets.secret_key_base).first
                        puts refresh_payload
                        existing_refresh_token = user.refresh_tokens.find_by_token(refresh_payload['id'])
                        raise JWT::VerificationError, token: 'refresh' unless existing_refresh_token.present?

                        token = user.generate_jwt
                        new_refresh_token = user.refresh_tokens.create!
                        existing_refresh_token.destroy!

                        cookies.signed[:token] = {value: token, httponly: true}
                        cookies.signed[:refresh_token] = {value: new_refresh_token.crypted_token, httponly: true}

                        @current_user_id = jwt_payload['id']
                    rescue JWT::ExpiredSignature
                        cookies.delete(:token)
                        cookies.delete(:refresh_token)
                        head :unauthorized
                    end
                end
            rescue JWT::VerificationError, JWT::DecodeError
                cookies.delete(:token)
                cookies.delete(:refresh_token)
                head :unauthorized
            end
        end
    end

    def current_user
        #@current_user ||= super || 
        User.find(@current_user_id)
    end

    def signed_in?
        @current_user_id.present?
    end

    def authenticate_user!(options = {})
        head :unauthorized unless signed_in?
    end

    def user_not_authorized
        render json: { errors: { 'err' => "You are not authorized to perform this action" } }, status: :unprocessable_entity
    end

end
