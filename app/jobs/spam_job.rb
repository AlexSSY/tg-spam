class SpamJob < ApplicationJob
  queue_as :default

  def perform(spam)
    sleep 30
    spam.update status: "completed"
  end
end
