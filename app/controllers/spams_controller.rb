class SpamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: %i[ start ]

  def new
    @spam = Spam.new
  end

  def start
  end

  def create
    @spam = Spam.new spam_params do |spam|
      spam.user_id = current_user.id
    end

    if @spam.save
      # bg-job started here
    else
      render(
        turbo_stream: turbo_stream.replace(
          "spam_form",
          partial: "spams/form",
          locals: {
            spam: @spam,
            messages: current_user.messages
          }
        ),
        status: :unprocessable_entity
      )
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
