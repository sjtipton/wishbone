class GamesController < ApplicationController

  def index
    if params[:week].present?
      Wildcat::Game.all(week: params[:week]) { |game| @schedule = game }
    else
      Wildcat::Game.all { |game| @schedule = game }
    end
    Wildcat::Config.hydra.run
  end

  def show
    Wildcat::Game.find(params[:id]) { |game| @game = game }
    Wildcat::Config.hydra.run
  end
end
