class User < ApplicationRecord
  attr_accessor :remember_cookie
  
  # before_create :generate_remember
  has_many :posts, dependent: :destroy
  has_secure_password

  def generate_remember
    self.remember_cookie = SecureRandom.urlsafe_base64
    update_attribute(:remember_token, Digest::SHA1.hexdigest(remember_cookie.to_s))
  end

  def authenticated?(r_c)
    return false if remember_token.nil?
    BCrypt::Password.new(remember_token)                                                     .is_password?(r_c)
  end

  def forget
    update_attribute(:remember_token, nil)
  end
end
