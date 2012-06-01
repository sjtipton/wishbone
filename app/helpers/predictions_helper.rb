module PredictionsHelper

  def date_range_for_current_week(games)
    if games.first.played_at.strftime("%b %e") != games.last.played_at.strftime("%b %e")
      date_range = "#{games.first.played_at.strftime("%b %e")}-#{games.last.played_at.strftime("%e")}, 2012"
    else
      date_range = "#{games.first.played_at.strftime("%b %e")}, 2012"
    end

    date_range.squeeze
  end
end
