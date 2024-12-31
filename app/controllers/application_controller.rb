class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  helper_method :user_signed_in?
  helper_method :current_user

  private

  def authenticate_user!
    redirect_to new_authentication_path, alert: "Please login first." unless user_signed_in?
  end

  def user_signed_in?
    current_user.present?
  end

  def current_user
    Current.user ||= User.find_by id: session[:user_id]
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logout
    reset_session
  end
end
