require 'spec_helper'
require 'support/hydra_spec_helper'
include HydraSpecHelper

describe GamesController do
  render_views

  before do
    @game = FactoryGirl.build(:game)

    stub_hydra
    stub_for_game_index([@game])
    stub_for_show_game(@game)
  end

  after { clear_get_stubs }

  describe "GET 'index'" do

    before { get :index }

    it "should be successful" do
      response.should be_success
    end

    it "should assign @schedule" do
      assigns(:schedule).should be_an(Array)
      assigns(:schedule).should_not be_empty
      assigns(:schedule).first.should be_a(Wildcat::Game)
      assigns(:schedule).first.attributes.should eq @game.attributes
    end

    it "should render 'games/index'" do
      response.should render_template('games/index')
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
      assigns(:game).attributes.should eq @game.attributes
    end

    it "should render 'games/show'" do
      response.should render_template('games/show')
    end
  end
end
