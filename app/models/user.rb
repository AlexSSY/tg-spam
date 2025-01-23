class User < ApplicationRecord
  has_secure_password
  has_many :accounts
  has_many :messages
  has_many :spams
  has_many :notifications

  validates :username, presence: true, uniqueness: true, length: { minimum: 6, maximum: 16 }
  validates :password, presence: true, length: { minimum: 6 }

  def has_active_spam?
    spams.where(status: "pending").exists?
  end

  def notify_success(text)
    notifications.create(
      text: "You already have a spam job.",
      notification_type: "success"
    )
  end

  def notify_fail(text)
    notifications.create(
      text: "You already have a spam job.",
      notification_type: "error"
    )
  end
end
