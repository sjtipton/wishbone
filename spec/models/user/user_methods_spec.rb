require 'spec_helper'

describe User do

  describe "methods" do

    describe "self.find_from_oauth" do

      before do
        @auth_hash = OmniAuth.config.mock_auth[:facebook]
      end

      context "when User exists" do

        before do
          @user = FactoryGirl.create(:user, email: @auth_hash['info']['email'],
                                         provider: @auth_hash['provider'],
                                              uid: @auth_hash['uid'])
          @result = User.find_from_oauth(@auth_hash)
        end

        it "should return the matching User" do
          @result.should be_a(User)
          @result.attributes.should eq @user.attributes
        end
      end

      context "when User does not exist" do

        before do
          @result = User.find_from_oauth(@auth_hash)
        end

        it "should return nil" do
          @result.should be_nil
        end
      end

      context "when auth_hash is empty" do

        before do
          @result = User.find_from_oauth({})
        end

        it "should return nil" do
          @result.should be_nil
        end
      end
    end
  end
end