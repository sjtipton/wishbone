require 'spec_helper'

describe SessionsController do
  render_views

  describe "POST 'authenticate_user'" do

    context "when successully authenticating though Facebook" do

      before do
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
        post :authenticate_user, provider: 'facebook'
      end

      it "should be permanent redirect" do
        response.status.should be(301)
      end

      it "should instantiate a user session" do
        request.session[:user].should_not be_nil
        request.session[:user][:uid].should_not be_nil
        request.session[:user][:provider].should eq 'facebook'
        request.session[:user][:info]['email'].should eq request.env['omniauth.auth']['info']['email']
        request.session[:user][:info]['first_name'].should eq request.env['omniauth.auth']['info']['first_name']
        request.session[:user][:info]['last_name'].should eq request.env['omniauth.auth']['info']['last_name']
        request.session[:user][:info]['name'].should eq request.env['omniauth.auth']['info']['name']
      end

      it "should redirect to root_path" do
        response.should redirect_to root_path
      end

      it "should set flash[:notice] as 'You have successfully been authenticated through Facebook'" do
        flash[:notice].should eq 'You have successfully been authenticated through Facebook'
      end
    end

    context "when Facebook does not return an auth hash" do

      context "when the omniauth origin is present" do

        before do
          request.env['omniauth.origin'] = schedule_path
          post :authenticate_user, provider: 'facebook'
        end

        it "should be permanent redirect" do
          response.status.should be(301)
        end

        it "should not instantiate a user session" do
          request.session[:user].should be_nil
        end

        it "should set flash[:alert] as 'Sorry, we were not able to authenticate you using your chosen sign on method'" do
          flash[:alert].should eq 'Sorry, we were not able to authenticate you using your chosen sign on method'
        end

        it "should redirect to request.env['omniauth.origin']" do
          response.should redirect_to request.env['omniauth.origin']
        end
      end

      context "when the omniauth origin is nil" do

        before do
          post :authenticate_user, provider: 'facebook'
        end

        it "should be permanent redirect" do
          response.status.should be(301)
        end

        it "should not instantiate a user session" do
          request.session[:user].should be_nil
        end

        it "should set flash[:alert] as 'Sorry, we were not able to authenticate you using your chosen sign on method'" do
          flash[:alert].should eq 'Sorry, we were not able to authenticate you using your chosen sign on method'
        end

        it "should redirect to root_path" do
          response.should redirect_to root_path
        end
      end
    end
  end

  describe "POST 'failure'" do

    context "when declining access or otherwise not valid" do

      context "when request.session[:return_uri] is present" do

        before do
          request.session[:return_uri] = schedule_path
          post :failure
        end

        it "should be permanent redirect" do
          response.status.should be(301)
        end

        it "should not instantiate a user session" do
          request.session[:user].should be_nil
        end

        it "should set flash[:alert] as 'Sorry, we were not able to authenticate you using your chosen sign on method'" do
          flash[:alert].should eq 'Sorry, we were not able to authenticate you using your chosen sign on method'
        end

        it "should redirect to request.session[:return_uri]" do
          response.should redirect_to request.session[:return_uri]
        end
      end

      context "when request.session[:return_uri] is nil" do

        before do
          post :failure
        end

        it "should be permanent redirect" do
          response.status.should be(301)
        end

        it "should not instantiate a user session" do
          request.session[:user].should be_nil
        end

        it "should set flash[:alert] as 'Sorry, we were not able to authenticate you using your chosen sign on method'" do
          flash[:alert].should eq 'Sorry, we were not able to authenticate you using your chosen sign on method'
        end

        it "should redirect to root_path" do
          response.should redirect_to root_path
        end
      end
    end
  end

  describe "GET 'destroy'" do

    before do
      request.session[:user] = OmniAuth.config.mock_auth[:facebook]
      request.session.should_not be_nil
      get :destroy
    end

    it "should be permanent redirect" do
      response.status.should be(301)
    end

    it "should destroy the user session" do
      request.session[:user].should be_nil
    end

    it "should set flash[:notice] as 'You are now signed out'" do
      flash[:notice].should eq 'You are now signed out'
    end

    it "should redirect to root_path" do
      response.should redirect_to root_path
    end
  end
end
