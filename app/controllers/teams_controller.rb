class TeamsController < ApplicationController

  def index
    Wildcat::Team.all { |team| @teams = team }
    Wildcat::Config.hydra.run
  end

  def show
    Wildcat::Team.find(params[:id]) { |team| @team = team }
    Wildcat::Config.hydra.run
  end
end