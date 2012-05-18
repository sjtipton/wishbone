require 'spec_helper'
require 'support/hydra_spec_helper'
include HydraSpecHelper

describe TeamsController do
  render_views

  before do
    @team = FactoryGirl.build(:team)

    stub_hydra
    stub_for_team_index([@team])
    stub_for_show_team(@team)
  end

  after { clear_get_stubs }

  describe "GET 'index'" do

    before { get :index }

    it "should be successful" do
      response.should be_success
    end

    it "should assign @teams" do
      assigns(:teams).should be_an(Array)
      assigns(:teams).should_not be_empty
      assigns(:teams).first.should be_a(Wildcat::Team)
      assigns(:teams).first.attributes.should eq @team.attributes
    end

    it "should render 'teams/index'" do
      response.should render_template('teams/index')
    end
  end

  describe "GET 'show'" do

    before { get :show, id: @team.id }

    it "should be successful" do
      response.should be_success
    end

    it "should assign @team" do
      assigns(:team).should_not be_nil
      assigns(:team).should be_a(Wildcat::Team)
      assigns(:team).attributes.should eq @team.attributes
    end

    it "should render 'teams/show'" do
      response.should render_template('teams/show')
    end
  end
end
