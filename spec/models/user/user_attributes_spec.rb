require 'spec_helper'

describe User do

  describe "attributes" do

    it { should respond_to(:email) }
    it { should respond_to(:uid) }
    it { should respond_to(:provider) }
    it { should respond_to(:sign_in_count) }
    it { should respond_to(:last_sign_in_at) }

    it { should allow_mass_assignment_of(:email) }
    it { should allow_mass_assignment_of(:uid) }
    it { should allow_mass_assignment_of(:provider) }
    it { should allow_mass_assignment_of(:sign_in_count) }
    it { should allow_mass_assignment_of(:last_sign_in_at) }

    it "should instantiate PROVIDERS" do
      User::PROVIDERS.should_not be_nil
      User::PROVIDERS.length.should be(1)
      User::PROVIDERS.first.should eq "facebook"
    end

    it "PROVIDERS should be frozen" do
      assert_raise(RuntimeError) { User::PROVIDERS.delete(User::PROVIDERS.sample) }
    end
  end
end
