class ForecastsController < ApplicationController
  before_filter :authenticate_user_with_facebook!

  def new
    @user = User.find_by_uid(current_facebook_user[:uid])
    @forecast = @user.forecasts.new
  end

  def create
    @user = User.find_by_uid(current_facebook_user[:uid])
    @forecast = @user.forecasts.new(params[:forecast])

    if @forecast.save
      redirect_to new_prediction_path(forecast_id: @forecast.id), status: :moved_permanently
    else
      render action: 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find_by_uid(current_facebook_user[:uid])
    @forecast = Forecast.find(params[:id])
  end

  def update
    @user = User.find_by_uid(current_facebook_user[:uid])
    @forecast = Forecast.find(params[:id])

    if @forecast.update_attributes(params[:forecast])
      redirect_to user_path(@user.id), status: :moved_permanently
    else
      render action: 'edit', status: :unprocessable_entity
    end
  end
end
