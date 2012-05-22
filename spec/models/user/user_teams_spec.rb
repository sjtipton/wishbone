require 'spec_helper'

describe User do

  describe "teams" do

    before do
      @attrs = FactoryGirl.attributes_for(:user)
    end

    context "with teams" do

      context "when valid" do

        it "should not be empty" do
          user = User.new(@attrs)
          user.teams.should_not be_empty
        end

        it { should allow_value([FactoryGirl.build(:team)]).for(:teams) }
        it { should allow_value([FactoryGirl.build(:team), FactoryGirl.build(:team)]).for(:teams) }
      end

      context "when invalid" do

        it { should_not allow_value(["Carolina Panthers"]).for(:teams) }
        it { should_not allow_value([24]).for(:teams) }
        it { should_not allow_value(["Carolina"]).for(:teams) }
        it { should_not allow_value(FactoryGirl.build(:team)).for(:teams) }
      end
    end

    context "with no teams" do

      it "should be empty" do
        user = User.new(@attrs.merge(teams: []))
        user.teams.should be_empty
      end
    end
  end
end