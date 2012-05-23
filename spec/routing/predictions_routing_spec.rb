require 'spec_helper'

describe PredictionsController do

  describe "routing" do

    before do
      @forecast_id = SecureRandom.random_number(1e2.to_i)
      @id = SecureRandom.random_number(1e3.to_i)
    end

    context "when valid" do

      it ":get '/forecasts/:forecast_id/predictions/new' should route to predictions#new" do
        { get: "/forecasts/#{@forecast_id}/predictions/new" }.
          should route_to("predictions#new", forecast_id: "#{@forecast_id}")
      end

      it ":post '/forecasts/:forecast_id/predictions' should route to predictions#create" do
        { post: "/forecasts/#{@forecast_id}/predictions" }.
          should route_to("predictions#create", forecast_id: "#{@forecast_id}")
      end

      it ":get '/forecasts/:forecast_id/predictions/:id/edit' should route to predictions#edit" do
        { get: "/forecasts/#{@forecast_id}/predictions/#{@id}/edit" }.
          should route_to("predictions#edit", forecast_id: "#{@forecast_id}", id: "#{@id}")
      end

      it ":put '/forecasts/:forecast_id/predictions/:id' should route to predictions#update" do
        { put: "/forecasts/#{@forecast_id}/predictions/#{@id}" }.
          should route_to("predictions#update", forecast_id: "#{@forecast_id}", id: "#{@id}")
      end
    end

    context "when invalid" do

      it ":get '/predictions' should not be routable" do
        { get: "/predictions" }.should_not be_routable
      end

      it ":get '/forecasts/:forecast_id/predictions' should not be routable" do
        { get: "/forecasts/#{@forecast_id}/predictions" }.should_not be_routable
      end

      it ":get '/predictions/:id' should not be routable" do
        { get: "/predictions/#{@id}" }.should_not be_routable
      end

      it ":get '/forecasts/:forecast_id/predictions/:id' should not be routable" do
        { get: "/forecasts/#{@forecast_id}/predictions/#{@id}" }.should_not be_routable
      end

      it ":delete '/predictions/:id' should not be routable" do
        { delete: "/predictions/#{@id}" }.should_not be_routable
      end

      it ":delete '/forecasts/:forecast_id/predictions/:id' should not be routable" do
        { delete: "/forecasts/#{@forecast_id}/predictions/#{@id}" }.should_not be_routable
      end

      context "given a non-integer :id for an otherwise valid route" do

        it ":get '/forecasts/one/predictions/two/edit' should not be routable" do
          { get: "/forecasts/one/predictions/two/edit" }.should_not be_routable
        end

        it ":put '/forecasts/one/predictions/two' should not be routable" do
          { put: "/forecasts/one/predictions/two" }.should_not be_routable
        end
      end
    end
  end
end