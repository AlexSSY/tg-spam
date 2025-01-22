class User < ApplicationRecord
  has_secure_password
  has_many :accounts
  has_many :messages
  has_many :spams

  validates :username, presence: true, uniqueness: true, length: { minimum: 6, maximum: 16 }
  validates :password, presence: true, length: { minimum: 6 }

  def active_spam
    spams.where(status: "pending").last
  end
end
