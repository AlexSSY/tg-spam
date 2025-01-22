class SpamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: %i[ start ]

  def new
    @spam = Spam.new
  end

  def start
    @spam = Spam.new
  end

  def status
    @spam = Spam.new
  end

  def create
    @spam = Spam.new spam_params do |spam|
      spam.user_id = current_user.id
    end

    if @spam.save
      # bg-job started here
      SpamJob.perform_later @spam
      redirect_to status_spams_path
    else
    end
  end

  private

  def spam_params
    params.require(:spam).permit(:message_id)
  end

  def set_message
    @message = current_user.messages.find_by id: params[:id]
  end
end
