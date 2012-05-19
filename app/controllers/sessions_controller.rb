class SessionsController < ApplicationController

  def authenticate_user
    auth_hash = request.env['omniauth.auth']

    unless auth_hash.present?
      redirect_to request.env['omniauth.origin'] || root_path,
               status: 301,
                alert: "Sorry, we were not able to authenticate you using your chosen sign on method" and return
    end

    session[:user] = { info: auth_hash['info'],
                        uid: auth_hash['uid'],
                   provider: auth_hash['provider'] }
    redirect_to root_path, status: 301, notice: "You have successfully been authenticated through Facebook" and return
  end

  def failure
    redirect_to session[:return_uri] || root_path,
               status: 301,
                alert: "Sorry, we were not able to authenticate you using your chosen sign on method" and return
  end
end
