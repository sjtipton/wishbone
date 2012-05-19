require 'spec_helper'

describe User do

  describe "validations" do

    subject { FactoryGirl.create(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:uid) }
    it { should validate_presence_of(:provider) }

    it { should validate_uniqueness_of(:uid) }
    it { should validate_uniqueness_of(:email).scoped_to(:uid).
         with_message(/User already exists/) }

    it { should validate_numericality_of(:sign_in_count) }

    it { should_not allow_value("a@!d.com").for(:email) }
    it { should allow_value("example@example.com").for(:email) }
    it { should allow_value("facebook").for(:provider) }
    it { should_not allow_value("google").for(:provider) }
    it { should_not allow_value("random_value").for(:provider) }
  end
end
