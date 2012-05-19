class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def authenticate_user_with_facebook!
    redirect_to authentication_menu_path unless current_facebook_user.present?
  end

  def current_facebook_user
    session[:user]
  end
end
