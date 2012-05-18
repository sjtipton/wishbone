require 'spec_helper'

describe GamesController do

  before do
    @game = FactoryGirl.build(:game)
  end

  describe "GET 'index'" do

    before { get :index }

    it "should be successful" do
      response.should be_success
    end
  end

  describe "GET 'show'" do

    before { get :show, id: @game.id }

    it "should be successful" do
      response.should be_success
    end
  end
end
