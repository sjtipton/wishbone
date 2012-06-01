require 'spec_helper'
require 'support/hydra_spec_helper'
include HydraSpecHelper

describe Prediction do

  describe "game" do

    before do
      @game = FactoryGirl.build(:game)
      @prediction = FactoryGirl.build(:prediction, game_id: @game.id)
      stub_hydra
    end

    it "should respond to game" do
      @prediction.should respond_to(:game)
    end

    context "when valid" do

      before { stub_for_show_game(@game) }

      after { clear_get_stubs }

      it "should return a Wildcat::Game" do
        @prediction.game.should be_a(Wildcat::Game)
        @prediction.game.id.should eq @prediction.game_id
      end
    end
  end
end
