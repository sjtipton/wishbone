require 'spec_helper'

describe TeamGamesController do

  before do
    @team = FactoryGirl.build(:team)
  end

  describe "GET 'index'" do

    before { get :index, id: @team.id }

    it "should be successful" do
      response.should be_success
    end
  end
end
