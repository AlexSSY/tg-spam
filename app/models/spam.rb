class Spam < ApplicationRecord
  has_many :spam_accounts, dependent: :destroy
  has_many :accounts, through: :spam_accounts
end
