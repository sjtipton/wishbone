class TeamsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << "must contain valid Wildcat::Team objects" unless is_array_of_valid_wildcat_team_objects?(value)
  end

  private

  def is_array_of_valid_wildcat_team_objects?(values)
    return false unless values.is_a?(Array)

    values.each do |value|
      return false unless value.is_a?(Wildcat::Team)
    end
  end
end

class User < ActiveRecord::Base
  include ActiveModel::Validations

  has_many :forecasts, dependent: :destroy
  has_many :predictions, through: :forecasts

  attr_accessible :email, :last_sign_in_at, :provider, :sign_in_count, :uid, :teams

  serialize :teams, Array

  PROVIDERS = ["facebook"].freeze

  validates :email, :uid, :provider, presence: true
  validates :uid, uniqueness: true
  validates :email, uniqueness: { scope: :uid,
                                message: "User already exists" }
  validates :sign_in_count, numericality: true
  validates :provider, inclusion: { in: PROVIDERS, message: "not valid" }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                              message: "is not an email." }
  validates :teams, teams: true

  def self.find_from_oauth(auth_hash)
    if auth_hash.present?
      user = User.where(email: auth_hash['info']['email']).first
    end
    user
  end
end
