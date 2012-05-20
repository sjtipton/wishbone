class Prediction < ActiveRecord::Base
  attr_accessible :game_id, :losing_team_id, :losing_team_score, :winning_team_id, :winning_team_score

  validates :game_id, :losing_team_id, :winning_team_id, presence: true
  validates :winning_team_score, presence: true, if: "losing_team_score.present?"
  validates :losing_team_score, presence: true, if: "winning_team_score.present?"
  validates :game_id, :losing_team_id, :winning_team_id, numericality: { greater_than: 0 }
  validates :losing_team_score, :winning_team_score, numericality: { allow_nil: true }
  validate :winning_team_score_must_be_greater_than_or_equal_to_losing_team_score

  def winning_team_score_must_be_greater_than_or_equal_to_losing_team_score
    if self.winning_team_score.present? && self.losing_team_score.present?
      if self.winning_team_score < self.losing_team_score
        errors.add(:winning_team_score, "cannot be less than losing_team_score")
      end
    end
  end
end
