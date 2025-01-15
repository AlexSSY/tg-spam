class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new create_params

    if @user.save
      login @user
      redirect_to root_path, notice: "registered"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
