class Spam < ApplicationRecord
  has_many :spam_accounts, dependent: :destroy
  has_many :accounts, through: :spam_accounts
  belongs_to :message

  validates_presence_of :message
end
