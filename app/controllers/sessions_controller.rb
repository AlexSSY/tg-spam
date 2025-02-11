class SessionsController < ApplicationController
  before_action :ensure_unauthorized!, only: %i[ new create ]

  def new
    @user = User.new
  end

  def create
    @user = User.authenticate_by create_params

    if @user.present?
      login @user
      redirect_to root_path, notice: "logged in"
    else
      provide_errors
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to new_session_path
  end

  private

  def create_params
    params.require(:user).permit(:username, :password)
  end

  def provide_errors
    @user = User.new
    @user.errors.add(:username, "wrong username")
    @user.errors.add(:password, "wrong password")
  end
end
