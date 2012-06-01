require 'spec_helper'

describe PredictionsHelper do

  describe "#date_range_for_current_week" do

    before do
      @games = FactoryGirl.build_list(:game, 2, week: 1)
    end

    context "when the first and last date are different" do

      before do
        @games.last.played_at = 2.days.from_now
        @earliest_date = @games.first.played_at
        @latest_date = @games.last.played_at
      end

      it "should return the date range for the given week" do
        date_range = "#{@earliest_date.strftime("%b %e")}-#{@latest_date.strftime("%e")}, 2012"
        helper.date_range_for_current_week(@games).should eq date_range.squeeze
      end
    end

    context "when the first and last date are identical" do

      before do
        @earliest_date = @games.first.played_at
        @latest_date = @games.last.played_at
      end

      it "should return the first date for the given week" do
        date_range = "#{@earliest_date.strftime("%b %e")}, 2012"
        helper.date_range_for_current_week(@games).should eq date_range.squeeze
      end
    end
  end
end
