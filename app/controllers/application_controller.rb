class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method [ :authenticate_user_with_facebook!,
                  :current_facebook_user,
                  :facebook_user_signed_in? ]

  private

  def authenticate_user_with_facebook!
    redirect_to authentication_menu_path unless facebook_user_signed_in?
  end

  def current_facebook_user
    session[:user]
  end

  def facebook_user_signed_in?
    current_facebook_user.present?
  end
end
