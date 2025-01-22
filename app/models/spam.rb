class Spam < ApplicationRecord
  has_many :spam_accounts, dependent: :destroy
  has_many :accounts, through: :spam_accounts
  belongs_to :message

  validates_presence_of :message_id

  after_update_commit do
    broadcast_replace_to "spams", target: "spam_#{id}_status", partial: "spams/status", locals: { spam: self }
  end
end
