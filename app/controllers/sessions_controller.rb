class SessionsController < ApplicationController

  def authenticate_user
    auth_hash = request.env['omniauth.auth']

    unless auth_hash.present?
      redirect_to request.env['omniauth.origin'] || root_path,
               status: 301,
                alert: "Sorry, we were not able to authenticate you using your chosen sign on method" and return
    end

    sign_in_and_persist_new_or_existing_user(auth_hash)

    redirect_to root_path, status: 301, notice: "You have successfully been authenticated through Facebook"
  end

  def failure
    redirect_to session[:return_uri] || root_path,
               status: 301,
                alert: "Sorry, we were not able to authenticate you using your chosen sign on method"
  end

  def destroy
    session[:user] = nil
    redirect_to root_path, status: 301, notice: "You are now signed out"
  end
end
