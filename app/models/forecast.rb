class Forecast < ActiveRecord::Base
  has_many :predictions, dependent: :destroy
  belongs_to :user

  attr_accessible :title, :user_id

  validates :title, :user_id, presence: true
  validates :user_id, numericality: { greater_than: 0 }
  validates :title, length: { maximum: 64 }
end
