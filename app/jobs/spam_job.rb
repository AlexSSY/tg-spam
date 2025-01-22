class SpamJob < ApplicationJob
  queue_as :default

  def perform(spam)
    sleep 15
    spam.update status: "completed"
  end
end
