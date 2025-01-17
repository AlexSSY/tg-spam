class AccountPolicy < ApplicationPolicy
  attr_reader :user, :account

  def initialize(user, account)
    @user = user
    @account = account
  end

  def delete?
    # Удалять фккаунт телеги может только пользователь который им владеет
    account.user_id == user.id
  end
end
