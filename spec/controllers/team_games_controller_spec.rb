require 'spec_helper'
require 'support/hydra_spec_helper'
include HydraSpecHelper

describe TeamGamesController do
  render_views

  before do
    @team = FactoryGirl.build(:team)
    @games = []
    @games << FactoryGirl.build(:game, home_team_id: @team.id)
    @games << FactoryGirl.build(:game, away_team_id: @team.id)

    stub_hydra
    stub_for_show_team(@team)
    stub_for_team_game_index(@games)
  end

  after { clear_get_stubs }

  describe "GET 'index'" do

    before { get :index, id: @team.id }

    it "should be successful" do
      response.should be_success
    end

    it "should assign @team" do
      assigns(:team).should_not be_nil
      assigns(:team).should be_a(Wildcat::Team)
      assigns(:team).attributes.should eq @team.attributes
    end

    it "should assign @games" do
      assigns(:games).should be_an(Array)
      assigns(:games).should_not be_empty
      assigns(:games).first.should be_a(Wildcat::Game)
      assigns(:games).first.home_team_id.should eq @team.id
      assigns(:games).last.away_team_id.should eq @team.id
    end

    it "should render 'games/index'" do
      response.should render_template('team_games/index')
    end
  end
end
