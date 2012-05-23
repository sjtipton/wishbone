require 'spec_helper'

describe PredictionsController do
  render_views

  before do
    @user = FactoryGirl.create(:user)
    @forecast = FactoryGirl.create(:forecast, user_id: @user.id)
    @prediction = FactoryGirl.create(:prediction, forecast_id: @forecast.id)
  end

  context "when not authenticated through Facebook" do

    describe "GET 'new'" do

      before { get :new, forecast_id: @forecast.id }

      it "should be redirected" do
        response.status.should be(302)
      end

      it "should not assign @user" do
        assigns(:user).should be_nil
      end

      it "should not assign @forecast" do
        assigns(:forecast).should be_nil
      end

      it "should not assign @prediction" do
        assigns(:prediction).should be_nil
      end

      it "should not assign @games" do
        assigns(:games).should be_nil
      end

      it "should redirect to '/auth/facebook'" do
        response.should redirect_to '/auth/facebook'
      end
    end

    describe "POST 'create'" do

      before { post :create, forecast_id: @forecast.id,
                             predictions: @prediction.attributes }

      it "should be redirected" do
        response.status.should be(302)
      end

      it "should not assign @user" do
        assigns(:user).should be_nil
      end

      it "should not assign @forecast" do
        assigns(:forecast).should be_nil
      end

      it "should not assign @prediction" do
        assigns(:prediction).should be_nil
      end

      it "should not assign @games" do
        assigns(:games).should be_nil
      end

      it "should redirect to '/auth/facebook'" do
        response.should redirect_to '/auth/facebook'
      end
    end

    describe "GET 'edit'" do

      before { get :edit, forecast_id: @forecast.id,
                                   id: @prediction.id }

      it "should be redirected" do
        response.status.should be(302)
      end

      it "should not assign @user" do
        assigns(:user).should be_nil
      end

      it "should not assign @forecast" do
        assigns(:forecast).should be_nil
      end

      it "should not assign @prediction" do
        assigns(:prediction).should be_nil
      end

      it "should not assign @game" do
        assigns(:game).should be_nil
      end

      it "should redirect to '/auth/facebook'" do
        response.should redirect_to '/auth/facebook'
      end
    end

    describe "PUT 'update'" do

      before do
        @updated_attributes = @forecast.attributes.merge(winning_team_score: 34)
        put :update, forecast_id: @forecast.id,
                              id: @prediction.id,
                      prediction: @updated_attributes
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

      it "should not assign @prediction" do
        assigns(:prediction).should be_nil
      end

      it "should not assign @game" do
        assigns(:game).should be_nil
      end

      it "should redirect to '/auth/facebook'" do
        response.should redirect_to '/auth/facebook'
      end
    end
  end
end
