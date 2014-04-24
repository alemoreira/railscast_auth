class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :email, :password_hash, :password, :password_confirmation
  validates :email, :password, :password_confirmation, presence: true
  validates :password, confirmation: true
  validates :email, uniqueness: true
  before_save :encrypt_password

  def encrypt_password
    if password.present?
      self.password_hash = Digest::MD5.hexdigest(("qp10zm29" << password).upcase).upcase
    end
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == Digest::MD5.hexdigest(("qp10zm29" << password).upcase).upcase
      user
    else
      nil
    end
  end
end
