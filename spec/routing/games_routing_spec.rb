require 'spec_helper'

describe GamesController do

  describe "routing" do

    before do
      @id = SecureRandom.random_number(1e3.to_i)
    end

    context "when valid" do

      it ":get '/schedule' should route to games#index" do
        { get: "/schedule" }.should route_to("games#index")
      end

      it ":get '/games/:id'" do
        { get: "/games/#{@id}" }.should route_to("games#show", id: "#{@id}")
      end
    end

    context "when invalid" do

      it ":post '/schedule' should not be routable" do
        { post: "/schedule" }.should_not be_routable
      end

      it ":post '/games/:id' should not be routable" do
        { post: "/games/#{@id}" }.should_not be_routable
      end

      context "given a non-integer :id for an otherwise valid route" do

        it ":get '/games/one' should not be routable" do
          { get: "/games/one" }.should_not be_routable
        end
      end
    end
  end
end