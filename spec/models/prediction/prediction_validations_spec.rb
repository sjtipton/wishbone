require 'spec_helper'

describe Prediction do

  describe "validations" do

    subject { FactoryGirl.create(:prediction) }

    it { should validate_presence_of(:game_id) }
    it { should validate_presence_of(:winning_team_id) }
    it { should validate_presence_of(:losing_team_id) }
    it { should validate_presence_of(:forecast_id) }

    it { should allow_value(23).for(:game_id) }
    it { should allow_value(11).for(:winning_team_id) }
    it { should allow_value(2).for(:losing_team_id) }
    it { should allow_value(11).for(:forecast_id) }
    it { should_not allow_value(0).for(:game_id) }
    it { should_not allow_value(0).for(:winning_team_id) }
    it { should_not allow_value(0).for(:losing_team_id) }
    it { should_not allow_value(0).for(:forecast_id) }

    it { should allow_value(26).for(:winning_team_score) }
    it { should allow_value(7).for(:losing_team_score) }
    it { should_not allow_value('ten').for(:winning_team_score) }
    it { should_not allow_value('seven').for(:losing_team_score) }
  end

  context "when winning_team_score is provided without a losing_team_score" do

    before do
      @prediction = FactoryGirl.build(:prediction, winning_team_score: 24,
                                                    losing_team_score: nil)
    end

    it "should not be valid" do
      @prediction.should_not be_valid
    end
  end

  context "when losing_team_score is provided without a winning_team_score" do

    before do
      @prediction = FactoryGirl.build(:prediction, winning_team_score: nil,
                                                    losing_team_score: 17)
    end

    it "should not be valid" do
      @prediction.should_not be_valid
    end
  end

  context "when both team scores are not provided" do

    before do
      @prediction = FactoryGirl.build(:prediction, winning_team_score: nil,
                                                    losing_team_score: nil)
    end

    it "should be valid" do
      @prediction.should be_valid
    end
  end

  context "when winning_team_score is less than losing_team_score" do

    before do
      @prediction = FactoryGirl.build(:prediction, winning_team_score: 24,
                                                    losing_team_score: 25)
    end

    it "should not be valid" do
      @prediction.should_not be_valid
    end
  end
end
