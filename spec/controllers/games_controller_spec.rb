require 'spec_helper'
require 'support/hydra_spec_helper'
include HydraSpecHelper

describe GamesController do
  render_views

  before do
    @game = FactoryGirl.build(:game)

    stub_hydra
    stub_for_show_game(@game)
  end

  after { clear_get_stubs }

  describe "GET 'index'" do

    context "when not passing optional params for a particular week" do

      before do
        stub_for_game_index([@game])
        get :index
      end

      it "should be successful" do
        response.should be_success
      end

      it "should assign @schedule" do
        assigns(:schedule).should be_an(Array)
        assigns(:schedule).should_not be_empty
        assigns(:schedule).first.should be_a(Wildcat::Game)
        assigns(:schedule).first.id.should eq @game.id
        (1..17).to_a.should include assigns(:schedule).sample.week
      end

      it "should render 'games/index'" do
        response.should render_template('games/index')
      end
    end

    context "when passing optional params for a particular week" do

      before do
        @game = FactoryGirl.build(:game, week: 1)
        stub_for_game_index([@game], week: 1)
        get :index, week: 1
      end

      it "should be successful" do
        response.should be_success
      end

      it "should assign @schedule" do
        assigns(:schedule).should be_an(Array)
        assigns(:schedule).should_not be_empty
        assigns(:schedule).first.should be_a(Wildcat::Game)
        assigns(:schedule).first.id.should eq @game.id
        assigns(:schedule).sample.week.should be(1)
      end

      it "should render 'games/index'" do
        response.should render_template('games/index')
      end
    end
  end

  describe "GET 'show'" do

    before { get :show, id: @game.id }

    it "should be successful" do
      response.should be_success
    end

    it "should assign @game" do
      assigns(:game).should_not be_nil
      assigns(:game).should be_a(Wildcat::Game)
      assigns(:game).id.should eq @game.id
    end

    it "should render 'games/show'" do
      response.should render_template('games/show')
    end
  end
end
