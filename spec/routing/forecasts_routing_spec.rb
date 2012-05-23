require 'spec_helper'

describe ForecastsController do

  describe "routing" do

    before do
      @id = SecureRandom.random_number(1e2.to_i)
    end

    context "when valid" do

      it ":get '/forecasts/new' should route to forecasts#new" do
        { get: "/forecasts/new" }.should route_to("forecasts#new")
      end

      it ":post '/forecasts' should route to forecasts#create" do
        { post: "/forecasts" }.should route_to("forecasts#create")
      end

      it ":get '/forecasts/:id/edit' should route to forecasts#edit" do
        { get: "/forecasts/#{@id}/edit" }.should route_to("forecasts#edit", id: "#{@id}")
      end

      it ":put '/forecasts/:id' should route to forecasts#update" do
        { put: "/forecasts/#{@id}" }.should route_to("forecasts#update", id: "#{@id}")
      end
    end

    context "when invalid" do

      it ":get '/forecasts' should not be routable" do
        { get: "/forecasts" }.should_not be_routable
      end

      it ":get '/forecasts/:id' should not be routable" do
        { get: "/forecasts/#{@id}" }.should_not be_routable
      end

      it ":delete '/forecasts/:id' should not be routable" do
        { delete: "/forecasts/#{@id}" }.should_not be_routable
      end

      context "given a non-integer :id for an otherwise valid route" do

        it ":get '/forecasts/one/edit' should not be routable" do
          { get: "/forecasts/one/edit" }.should_not be_routable
        end

        it ":put '/forecasts/one' should not be routable" do
          { put: "/forecasts/one" }.should_not be_routable
        end
      end
    end
  end
end