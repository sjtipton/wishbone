require 'spec_helper'

describe Prediction do

  it { should belong_to(:forecast) }

  describe "attributes" do

    it { should respond_to(:game_id) }
    it { should respond_to(:winning_team_id) }
    it { should respond_to(:losing_team_id) }
    it { should respond_to(:winning_team_score) }
    it { should respond_to(:losing_team_score) }
    it { should respond_to(:forecast_id) }

    it { should allow_mass_assignment_of(:game_id) }
    it { should allow_mass_assignment_of(:winning_team_id) }
    it { should allow_mass_assignment_of(:losing_team_id) }
    it { should allow_mass_assignment_of(:winning_team_score) }
    it { should allow_mass_assignment_of(:losing_team_score) }
    it { should allow_mass_assignment_of(:forecast_id) }
  end
end
