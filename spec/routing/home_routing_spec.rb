require 'spec_helper'

describe HomeController do

  describe "routing" do

    context "when valid" do

      it ":get '/' should route to home#index" do
        { get: "/" }.should route_to("home#index")
      end

      it ":get '/authentication_menu' should route to home#authentication_menu" do
        { get: "/authentication_menu" }.should route_to("home#authentication_menu")
      end
    end

    context "when invalid" do

      it ":post '/authentication_menu' should not be routable" do
        { post: "/authentication_menu" }.should_not be_routable
      end
    end
  end
end
