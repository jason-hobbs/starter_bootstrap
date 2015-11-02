class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true,
                  format: /\A\S+@\S+\z/,
                  uniqueness: { case_sensitive: false }

  def gravatar_id
  	Digest::MD5::hexdigest(email.downcase)
  end

  def self.clear_reset_tokens
    User.update_all(reset_token: nil)
  end

end
