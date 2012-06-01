require 'spec_helper'
require 'support/hydra_spec_helper'
include HydraSpecHelper

describe Prediction do

  describe "losing_team" do

    before do
      @team = FactoryGirl.build(:team)
      @game = FactoryGirl.build(:game, away_team_id: @team.id)
      @prediction = FactoryGirl.build(:prediction, losing_team_id: @team.id)
      stub_hydra
    end

    it "should respond to losing_team" do
      @prediction.should respond_to(:losing_team)
    end

    context "when valid" do

      before { stub_for_show_team(@team) }

      after { clear_get_stubs }

      it "should return a Wildcat::Team" do
        @prediction.losing_team.should be_a(Wildcat::Team)
        @prediction.losing_team.id.should eq @prediction.losing_team_id
      end
    end
  end
end
