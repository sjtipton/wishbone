class Forecast < ActiveRecord::Base
  attr_accessible :prediction_id, :title, :user_id

  validates :prediction_id, :title, :user_id, presence: true
  validates :prediction_id, :user_id, numericality: { greater_than: 0 }
  validates :title, length: { maximum: 64 }
end
