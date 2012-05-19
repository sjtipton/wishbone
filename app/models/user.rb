class User < ActiveRecord::Base
  attr_accessible :email, :last_sign_in_at, :provider, :sign_in_count, :uid

  PROVIDERS = ["facebook"].freeze

  validates :email, :uid, :provider, presence: true
  validates :uid, uniqueness: true
  validates :email, uniqueness: { scope: :uid,
                                message: "User already exists" }
  validates :sign_in_count, numericality: true
  validates :provider, inclusion: { in: PROVIDERS, message: "not valid" }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                              message: "is not an email." }
end
