require 'spec_helper'

describe UsersController do

  describe "routing" do

    before do
      @id = SecureRandom.random_number(1e4.to_i)
    end

    context "when valid" do

      it ":get '/users/:id' should route to users#show" do
        { get: "/users/#{@id}" }.should route_to("users#show")
      end
    end

    context "when invalid" do

      context "given a non-integer :id for an otherwise valid route" do

        it ":get '/users/one' should not be routable" do
          { get: "/users/one" }.should_not be_routable
        end
      end
    end
  end
end
