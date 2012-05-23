class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method [ :authenticate_user_with_facebook!,
                  :current_facebook_user,
                  :facebook_user_signed_in?,
                  :sign_in_and_persist_new_or_existing_user ]

  private

  def authenticate_user_with_facebook!
    redirect_to "/auth/facebook" unless facebook_user_signed_in?
  end

  def current_facebook_user
    session[:user]
  end

  def facebook_user_signed_in?
    current_facebook_user.present?
  end

  def sign_in_and_persist_new_or_existing_user(auth_hash)
    session[:user] = { info: auth_hash['info'],
                        uid: auth_hash['uid'],
                   provider: auth_hash['provider'] }

    existing_user = User.find_from_oauth(auth_hash)

    if existing_user.present?
      existing_user.increment(:sign_in_count)
      existing_user.last_sign_in_at = Time.now
      existing_user.save
    else
      new_user = User.new(email: auth_hash['info']['email'],
                            uid: auth_hash['uid'],
                       provider: auth_hash['provider'],
                  sign_in_count: 1,
                last_sign_in_at: Time.now)
      new_user.save
    end
  end
end
