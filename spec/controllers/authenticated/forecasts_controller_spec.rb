require 'spec_helper'

describe ForecastsController do
  render_views

  context "when authenticated through Facebook" do

    before do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]

      request.session[:user] = { info: request.env['omniauth.auth']['info'],
                                  uid: request.env['omniauth.auth']['uid'],
                             provider: request.env['omniauth.auth']['provider'] }

      @user = FactoryGirl.create(:user, uid: request.session[:user][:uid],
                                   provider: request.session[:user][:provider])
      @attrs = FactoryGirl.attributes_for(:forecast, user_id: @user.id)
      @forecast = FactoryGirl.create(:forecast, user_id: @user.id)
    end

    describe "GET 'new'" do

      before { get :new }

      it "should be successful" do
        response.should be_success
      end

      it "should assign @user" do
        assigns(:user).should be_a(User)
        assigns(:user).id.should eq @forecast.user_id
        assigns(:user).uid.should eq request.session[:user][:uid]
      end

      it "should assign @forecast" do
        assigns(:forecast).should be_a(Forecast)
        assigns(:forecast).user_id.should eq @user.id
      end

      it "should render 'forecasts/new'" do
        response.should render_template('forecasts/new')
      end
    end

    describe "POST 'create'" do

      before { post :create, forecast: @attrs }

      it "should be successful and redirect" do
        response.status.should be(301)
      end

      it "should assign @user" do
        assigns(:user).should be_a(User)
        assigns(:user).id.should eq @forecast.user_id
        assigns(:user).uid.should eq request.session[:user][:uid]
      end

      it "should assign @forecast" do
        assigns(:forecast).should be_a(Forecast)
        assigns(:forecast).user_id.should eq @user.id
      end

      it "should redirect to 'predictions#new'" do
        response.should redirect_to new_prediction_path(forecast_id: assigns(:forecast).id)
      end
    end

    describe "GET 'edit'" do

      before { get :edit, id: @forecast.id }

      it "should be successful" do
        response.should be_success
      end

      it "should assign @user" do
        assigns(:user).should be_a(User)
        assigns(:user).id.should eq @forecast.user_id
        assigns(:user).uid.should eq request.session[:user][:uid]
      end

      it "should assign @forecast" do
        assigns(:forecast).should be_a(Forecast)
        assigns(:forecast).user_id.should eq @user.id
      end

      it "should render 'forecasts/edit'" do
        response.should render_template('forecasts/edit')
      end
    end

    describe "PUT 'update'" do

      before do
        @updated_attributes = @attrs.merge(title: "My Fearless Forecast")
        put :update, id: @forecast.id, forecast: @updated_attributes
      end

      it "should be successful and redirect" do
        response.status.should be(301)
      end

      it "should assign @user" do
        assigns(:user).should be_a(User)
        assigns(:user).id.should eq @forecast.user_id
        assigns(:user).uid.should eq request.session[:user][:uid]
      end

      it "should assign @forecast" do
        assigns(:forecast).should be_a(Forecast)
        assigns(:forecast).user_id.should eq @user.id
        assigns(:forecast).title.should eq @updated_attributes[:title]
      end

      it "should redirect to 'users#show'" do
        response.should redirect_to user_path(@user.id)
      end
    end
  end
end
