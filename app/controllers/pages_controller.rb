class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: %i[ home ]

  def home
  end

  private

  def set_message
    @message = current_user.messages.find_by id: params[:message_id]
  end
end
