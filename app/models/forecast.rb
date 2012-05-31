class Forecast < ActiveRecord::Base
  has_many :predictions, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :predictions

  attr_accessible :title, :user_id, :predictions_attributes

  validates :title, :user_id, presence: true
  validates :user_id, numericality: { greater_than: 0 }
  validates :title, length: { maximum: 64 }
end
