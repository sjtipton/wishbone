require 'spec_helper'

describe Prediction do

  before do
    @attrs = FactoryGirl.attributes_for(:prediction)
  end

  describe "attributes" do

    it { should respond_to(:game_id) }
    it { should respond_to(:winning_team_id) }
    it { should respond_to(:losing_team_id) }
    it { should respond_to(:winning_team_score) }
    it { should respond_to(:losing_team_score) }

    it { should allow_mass_assignment_of(:game_id) }
    it { should allow_mass_assignment_of(:winning_team_id) }
    it { should allow_mass_assignment_of(:losing_team_id) }
    it { should allow_mass_assignment_of(:winning_team_score) }
    it { should allow_mass_assignment_of(:losing_team_score) }
  end
end
