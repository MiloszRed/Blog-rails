class RefreshToken < ApplicationRecord
  belongs_to :user
  after_create :set_crypted_token

  attr_accessor :token

  def self.find_by_token(token)
    RefreshToken.find_by(id: token)
  end

  private

  def set_crypted_token
    #self.token = SecureRandom.hex
    #self.crypted_token = Digest::SHA256.hexdigest(token)
    self.crypted_token = JWT.encode({id: id, exp: 2.days.from_now.to_i}, Rails.application.secrets.secret_key_base,)
  end
end
