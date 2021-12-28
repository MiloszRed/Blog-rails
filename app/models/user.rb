class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :comments, dependent: :destroy
  has_many :refresh_tokens, dependent: :delete_all

  def generate_jwt
    JWT.encode({id: id, exp: 30.minutes.from_now.to_i}, Rails.application.secrets.secret_key_base,)
  end

end
