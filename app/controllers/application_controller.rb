class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  include Pundit::Authorization
  helper_method :user_signed_in?
  helper_method :current_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back_or_to(root_path)
  end

  def authenticate_user!
    redirect_to new_session_path, alert: "Please login first." unless user_signed_in?
  end

  def ensure_unauthorized!
    redirect_to root_path if user_signed_in?
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
