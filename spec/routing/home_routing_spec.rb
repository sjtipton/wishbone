require 'spec_helper'

describe HomeController do

  describe "routing" do

    it ":get '/' should route to home#index" do
      { get: "/" }.should route_to("home#index")
    end
  end
end
