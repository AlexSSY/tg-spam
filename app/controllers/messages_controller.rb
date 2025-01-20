class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: %i[show edit destroy]

  def index
    @messages = current_user.messages
  end

  def show
    @spam = Spam.new message_id: @message.id
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new message_params do |msg|
      msg.user_id = current_user.id
    end

    if @message.save
      redirect_to messages_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @message.update message_params
      redirect_to @message
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @message.destroy
    redirect_to messages_path
  end

  private

  def set_message
    @message = current_user.messages.find params[:id]
  end

  def message_params
    params.require(:message).permit(:caption, :image)
  end
end
