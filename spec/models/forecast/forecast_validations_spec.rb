require 'spec_helper'

describe Forecast do

  describe "validations" do

    subject { FactoryGirl.create(:forecast) }

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:user_id) }

    it { should allow_value(23).for(:user_id) }
    it { should_not allow_value(0).for(:user_id) }

    it { should allow_value("My First Forecast").for(:title) }
    it { should_not allow_value("a" * 65).for(:title) }
  end
end
