require 'spec_helper'

describe SessionsController do
  render_views

  describe "POST 'authenticate_user'" do

    context "when authenticating though Facebook" do

      before do
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
        post :authenticate_user, provider: 'facebook'
      end

      it "should be successful" do
        response.should be_success
      end

      it "should set user's email" do
        assigns(:user_data)[:info][:email].should == request.env["omniauth.auth"]["info"]["email"]
      end

      it "should set user's first name" do
        assigns(:user_data)[:info][:first_name].should == request.env["omniauth.auth"]["info"]["first_name"]
      end

      it "should set user's last name" do
        assigns(:user_data)[:info][:last_name].should == request.env["omniauth.auth"]["info"]["last_name"]
      end

      it "should set user's name" do
        assigns(:user_data)[:info][:name].should == request.env["omniauth.auth"]["info"]["name"]
      end

      it "should instantiate a user session" do
	    	request.session[:user].should_not be_nil
	    end
    end
  end
end
