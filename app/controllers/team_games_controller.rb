class TeamGamesController < ApplicationController

  def index
    Wildcat::Team.find(params[:id]) { |team| @team = team }
    Wildcat::Config.hydra.run

    @games = @team.games
  end
end