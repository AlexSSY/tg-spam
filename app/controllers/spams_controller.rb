class SpamsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_no_active_jobs, only: :create

  def start
    @spam = Spam.new
    @message = current_user.messages.find_by id: params[:id]
  end

  def status
    @spam = current_user.spams.find_by(id: params[:id])
  end

  def create
    @spam = Spam.new spam_params do |spam|
      spam.user_id = current_user.id
    end

    if @spam.save
      SpamJob.perform_later @spam
      redirect_to status_spam_path(@spam)
    else
    end
  end

  private

  def ensure_no_active_jobs
    if current_user.has_active_spam?
      current_user.notify_fail "You already have a spam job."

      head :forbidden
    end
  end

  def spam_params
    params.require(:spam).permit(:message_id)
  end
end
