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
end
