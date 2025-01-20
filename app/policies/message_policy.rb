class MessagePolicy < ApplicationPolicy
  attr_reader :user, :message

  def initialize(user, message)
    @user = user
    @message = message
  end

  def index?
    message.user_id == user.id
  end

  def show?
    message.user_id == user.id
  end

  def delete?
    # Удалять сообщение спама может только пользователь который им владеет
    message.user_id == user.id
  end
end
