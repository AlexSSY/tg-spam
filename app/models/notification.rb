class Notification < ApplicationRecord
  belongs_to :user

  validates :text, presence: true
  validates :notification_type, presence: true, inclusion: { in: [ "success", "error" ] }

  after_create_commit do
    broadcast_replace_to(
      "notifications_#{user.id}",
      target: "notification",
      partial: "notifications/notification",
      locals: { notification: self }
    )
  end
end
