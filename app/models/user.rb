class User < ApplicationRecord
  has_secure_password
  has_many :accounts

  validates :username, presence: true, uniqueness: true, length: { minimum: 6, maximum: 16 }
  validates :password, presence: true, length: { minimum: 6 }
end
