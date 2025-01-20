class SpamsController < ApplicationController
  before_action :authenticate_user!

  def new
    @spam = Spam.new
  end

  def create
    @spam = Spam.new spam_params do |spam|
      spam.user_id = current_user.id
    end

    if @spam.save
      # bg-job started here
    end
  end

  private

  def spam_params
    params.require(:spam).permit(:message_id)
  end
end
