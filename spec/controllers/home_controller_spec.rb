require 'spec_helper'

describe HomeController do
  render_views

  describe "GET 'index'" do

    before { get :index }

    it "should be successful" do
      response.should be_success
    end

    it "should render 'home/index'" do
      response.should render_template('home/index')
    end
  end

  describe "GET 'authentication_menu'" do

    before { get :authentication_menu }

    it "should be successful" do
      response.should be_success
    end

    it "should render 'home/authentication_menu'" do
      response.should render_template('home/authentication_menu')
    end
  end
end
