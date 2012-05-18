class GamesController < ApplicationController

  def index
    Wildcat::Game.all { |game| @schedule = game }
    Wildcat::Config.hydra.run
  end

  def show
    Wildcat::Game.find(params[:id]) { |game| @game = game }
    Wildcat::Config.hydra.run
  end
end