require 'spec_helper'
require 'support/hydra_spec_helper'
include HydraSpecHelper

describe PredictionsController do
  render_views

  before do
    @home_team = FactoryGirl.build(:team, name: "Dallas Cowboys", abbreviation: "DAL")
    @away_team = FactoryGirl.build(:team, name: "Washington Redskins", abbreviation: "WAS")
    @game = FactoryGirl.build(:game, home_team_id: @home_team.id, away_team_id: @away_team.id)

    stub_hydra
    stub_for_show_team(@home_team)
    stub_for_show_team(@away_team)
    stub_for_game_index([@game])
    stub_for_show_game(@game)
  end

  after { clear_get_stubs }

  context "when authenticated through Facebook" do

    before do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]

      request.session[:user] = { info: request.env['omniauth.auth']['info'],
                                  uid: request.env['omniauth.auth']['uid'],
                             provider: request.env['omniauth.auth']['provider'] }

      @user = FactoryGirl.create(:user, uid: request.session[:user][:uid],
                                   provider: request.session[:user][:provider])
      @forecast = FactoryGirl.create(:forecast, user_id: @user.id)
      @attrs = FactoryGirl.attributes_for(:prediction, forecast_id: @forecast.id, game_id: @game.id)
      @prediction = FactoryGirl.create(:prediction, @attrs)
    end

    describe "GET 'new'" do

      before { get :new, forecast_id: @forecast.id }

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

      it "should assign @prediction" do
        assigns(:prediction).should be_a(Prediction)
        assigns(:prediction).forecast_id.should eq @forecast.id
      end

      it "should assign @games" do
        assigns(:games).should be_an(Array)
        assigns(:games).should_not be_empty
        assigns(:games).first.should be_a(Wildcat::Game)
        assigns(:games).first.id.should eq @game.id
      end

      it "should render 'predictions/new'" do
        response.should render_template('predictions/new')
      end
    end

    describe "POST 'create'" do

      context "when valid" do

        before { post :create, forecast_id: @forecast.id,
                                prediction: @attrs }

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

        it "should assign @prediction" do
          assigns(:prediction).should be_a(Prediction)
          assigns(:prediction).forecast_id.should eq @forecast.id
        end

        it "should assign @games" do
          assigns(:games).should be_an(Array)
          assigns(:games).should_not be_empty
          assigns(:games).first.should be_a(Wildcat::Game)
          assigns(:games).first.id.should eq @game.id
        end

        it "should redirect to 'predictions#new'" do
          response.should redirect_to new_prediction_path(forecast_id: assigns(:forecast).id)
        end
      end

      context "when invalid" do

        before { post :create, forecast_id: @forecast.id,
                                prediction: @attrs.merge(winning_team_id: nil) }

        it "should be invalid" do
          response.status.should be(422)
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

        it "should assign @prediction" do
          assigns(:prediction).should be_a(Prediction)
          assigns(:prediction).forecast_id.should eq @forecast.id
        end

        it "should assign @games" do
          assigns(:games).should be_an(Array)
          assigns(:games).should_not be_empty
          assigns(:games).first.should be_a(Wildcat::Game)
          assigns(:games).first.id.should eq @game.id
        end

        it "should have errors" do
          assigns(:prediction).errors.any?.should be_true
          assigns(:prediction).errors.full_messages.should include("Winning team can't be blank")
        end

        it "should render 'predictions/new'" do
          response.should render_template('predictions/new')
        end
      end
    end

    describe "GET 'edit'" do

      before { get :edit, forecast_id: @forecast.id,
                                   id: @prediction.id }

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

      it "should assign @prediction" do
        assigns(:prediction).should be_a(Prediction)
        assigns(:prediction).forecast_id.should eq @forecast.id
      end

      it "should assign @game" do
        assigns(:game).should_not be_nil
        assigns(:game).should be_a(Wildcat::Game)
        assigns(:game).id.should eq @game.id
      end

      it "should render 'predictions/edit'" do
        response.should render_template('predictions/edit')
      end
    end

    describe "PUT 'update'" do

      context "when valid" do

        before do
          @updated_attributes = @attrs.merge(winning_team_score: 34)
          put :update, forecast_id: @forecast.id,
                                id: @prediction.id,
                        prediction: @updated_attributes
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
        end

        it "should assign @prediction" do
          assigns(:prediction).should be_a(Prediction)
          assigns(:prediction).forecast_id.should eq @forecast.id
          assigns(:prediction).winning_team_score.should eq @updated_attributes[:winning_team_score]
        end

        it "should assign @game" do
          assigns(:game).should_not be_nil
          assigns(:game).should be_a(Wildcat::Game)
          assigns(:game).id.should eq @game.id
        end

        it "should redirect to 'users#show'" do
          response.should redirect_to user_path(@user.id)
        end
      end

      context "when invalid" do

        before do
          @invalid_updated_attributes = @attrs.merge(winning_team_id: nil)
          put :update, forecast_id: @forecast.id,
                                id: @prediction.id,
                        prediction: @invalid_updated_attributes
        end

        it "should be invalid" do
          response.status.should be(422)
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

        it "should assign @prediction" do
          assigns(:prediction).should be_a(Prediction)
          assigns(:prediction).forecast_id.should eq @forecast.id
        end

        it "should assign @game" do
          assigns(:game).should_not be_nil
          assigns(:game).should be_a(Wildcat::Game)
          assigns(:game).id.should eq @game.id
        end

        it "should have errors" do
          assigns(:prediction).errors.any?.should be_true
          assigns(:prediction).errors.full_messages.should include("Winning team can't be blank")
        end

        it "should render 'predictions/edit'" do
          response.should render_template('predictions/edit')
        end
      end
    end
  end
end
