require 'spec_helper'

describe Prediction do

  it { should have_many(:forecasts) }
  it { should have_many(:users).through(:forecasts) }

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
