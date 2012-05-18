require 'spec_helper'

describe SessionsController do

  describe "routing" do

    context "when valid" do

      before { @provider = "facebook" }

      it ":get '/auth/:provider/callback' should route to sessions#authenticate_user" do
        { get: "/auth/#{@provider}/callback" }.should route_to("sessions#authenticate_user", provider: "#{@provider}")
      end

      it ":post '/auth/:provider/callback' should route to sessions#authenticate_user" do
        { post: "/auth/#{@provider}/callback" }.should route_to("sessions#authenticate_user", provider: "#{@provider}")
      end

      it ":get '/auth/failure' should route to sessions#failure" do
        { get: "/auth/failure" }.should route_to("sessions#failure")
      end

      it ":post '/auth/failure' should route to sessions#failure" do
        { post: "/auth/failure" }.should route_to("sessions#failure")
      end
    end

    context "when invalid" do

      context "given a provider other than facebook" do

        it ":get '/auth/google/callback' should not be routable" do
          { get: "/auth/google/callback" }.should_not be_routable
        end
      end
    end
  end
end
