require 'spec_helper'
require 'support/hydra_spec_helper'
include HydraSpecHelper

describe Prediction do

  describe "winning_team" do

    before do
      @team = FactoryGirl.build(:team)
      @game = FactoryGirl.build(:game, away_team_id: @team.id)
      @prediction = FactoryGirl.build(:prediction, winning_team_id: @team.id)
      stub_hydra
    end

    it "should respond to winning_team" do
      @prediction.should respond_to(:winning_team)
    end

    context "when valid" do

      before { stub_for_show_team(@team) }

      after { clear_get_stubs }

      it "should return a Wildcat::Team" do
        @prediction.winning_team.should be_a(Wildcat::Team)
        @prediction.winning_team.id.should eq @prediction.winning_team_id
      end
    end
  end
end
