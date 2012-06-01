class PredictionsController < ApplicationController
  before_filter :authenticate_user_with_facebook!

  def new
    @user = User.find_by_uid(current_facebook_user[:uid])
    @forecast = Forecast.find(params[:forecast_id])
    @prediction = @forecast.predictions.new
    @current_week = params[:week] || 1
    Wildcat::Game.all(week: @current_week) { |game| @games = game }
    Wildcat::Config.hydra.run
  end

  def create
    @user = User.find_by_uid(current_facebook_user[:uid])
    @forecast = Forecast.find(params[:forecast_id])
    @prediction = @forecast.predictions.new(params[:prediction])
    @current_week = params[:week] || 1
    Wildcat::Game.all(week: @current_week) { |game| @games = game }
    Wildcat::Game.find(@prediction.game_id) { |game| @game = game }
    Wildcat::Config.hydra.run

    if @prediction.winning_team_id == @game.home_team_id
      @prediction.losing_team_id = @game.away_team_id
    else
      @prediction.losing_team_id = @game.home_team_id
    end

    if @prediction.save
      redirect_to new_prediction_path(forecast_id: @forecast.id), status: :moved_permanently
    else
      render action: 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find_by_uid(current_facebook_user[:uid])
    @forecast = Forecast.find(params[:forecast_id])
    @prediction = Prediction.find(params[:id])
    Wildcat::Game.find(@prediction.game_id) { |game| @game = game }
    Wildcat::Config.hydra.run
  end

  def update
    @user = User.find_by_uid(current_facebook_user[:uid])
    @forecast = Forecast.find(params[:forecast_id])
    @prediction = Prediction.find(params[:id])
    Wildcat::Game.find(@prediction.game_id) { |game| @game = game }
    Wildcat::Config.hydra.run

    if @prediction.update_attributes(params[:prediction])
      redirect_to user_path(@user.id), status: :moved_permanently
    else
      render action: 'edit', status: :unprocessable_entity
    end
  end
end
