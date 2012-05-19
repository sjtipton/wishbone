require 'spec_helper'

describe TeamsController do

  describe "routing" do

    before do
      @id = SecureRandom.random_number(1e3.to_i)
    end

    context "when valid" do

      it ":get '/teams' should route to teams#index" do
        { get: "/teams" }.should route_to("teams#index")
      end

      it ":get '/teams/:id'" do
        { get: "/teams/#{@id}" }.should route_to("teams#show", id: "#{@id}")
      end
    end

    context "when invalid" do

      it ":post '/teams' should not be routable" do
        { post: "/teams" }.should_not be_routable
      end

      it ":post '/teams/:id' should not be routable" do
        { post: "/teams/#{@id}" }.should_not be_routable
      end

      context "given a non-integer :id for an otherwise valid route" do

        it ":get '/teams/one' should not be routable" do
          { get: "/teams/one" }.should_not be_routable
        end
      end
    end
  end
end