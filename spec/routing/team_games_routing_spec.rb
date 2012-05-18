require 'spec_helper'

describe TeamGamesController do

  describe "routing" do

    before do
      @id = SecureRandom.random_number(1e2.to_i)
    end

    context "when valid" do

      it ":get '/teams/:id/schedule' should route to team_games#index" do
        { get: "/teams/#{@id}/schedule" }.should route_to("team_games#index", id: "#{@id}")
      end
    end

    context "when invalid" do

      context "given a non-integer :id for an otherwise valid route" do

        it ":get '/teams/one/schedule' should not be routable" do
          { get: "/teams/one/schedule" }.should_not be_routable
        end
      end
    end
  end
end