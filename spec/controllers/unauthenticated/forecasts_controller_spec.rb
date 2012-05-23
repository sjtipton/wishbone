require 'spec_helper'

describe ForecastsController do
  render_views

  before do
    @user = FactoryGirl.create(:user)
    @forecast = FactoryGirl.create(:forecast, user_id: @user.id)
  end

  context "when not authenticated through Facebook" do

    describe "GET 'new'" do

      before { get :new }

      it "should be redirected" do
        response.status.should be(302)
      end

      it "should not assign @user" do
        assigns(:user).should be_nil
      end

      it "should not assign @forecast" do
        assigns(:forecast).should be_nil
      end

      it "should redirect to '/auth/facebook'" do
        response.should redirect_to '/auth/facebook'
      end
    end

    describe "POST 'create'" do

      before { post :create, forecast: @forecast.attributes }

      it "should be redirected" do
        response.status.should be(302)
      end

      it "should not assign @user" do
        assigns(:user).should be_nil
      end

      it "should not assign @forecast" do
        assigns(:forecast).should be_nil
      end

      it "should redirect to '/auth/facebook'" do
        response.should redirect_to '/auth/facebook'
      end
    end

    describe "GET 'edit'" do

      before { get :edit, id: @forecast.id }

      it "should be redirected" do
        response.status.should be(302)
      end

      it "should not assign @user" do
        assigns(:user).should be_nil
      end

      it "should not assign @forecast" do
        assigns(:forecast).should be_nil
      end

      it "should redirect to '/auth/facebook'" do
        response.should redirect_to '/auth/facebook'
      end
    end

    describe "PUT 'update'" do

      before do
        @updated_attributes = @forecast.attributes.merge(title: "My Fearless Forecast")
        put :update, id: @forecast.id, forecast: @updated_attributes
      end

      it "should be redirected" do
        response.status.should be(302)
      end

      it "should not assign @user" do
        assigns(:user).should be_nil
      end

      it "should not assign @forecast" do
        assigns(:forecast).should be_nil
      end

      it "should redirect to '/auth/facebook'" do
        response.should redirect_to '/auth/facebook'
      end
    end
  end
end
