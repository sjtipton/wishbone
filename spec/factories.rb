FactoryGirl.define do

  factory :team, class: Wildcat::Team do
    id            { SecureRandom.random_number(1e2.to_i) }
    name          { ["Baltimore Ravens", "Carolina Panthers"].sample }
    nickname      { name.split(' ').last }
    abbreviation  { ["BAL", "CAR"].sample }
    location      { "#{Forgery(:address).city}, #{Forgery(:address).state_abbrev}" }
    conference    { %w(AFC NFC).sample }
    division      { %w(North South East West).sample }
  end

  factory :game, class: Wildcat::Game do
    id            { SecureRandom.random_number(1e3.to_i) }
    label         { "Ravens at Panthers" }
    season        { Forgery(:date).year }
    stadium       { "Bank of America Stadium" }
    week          { (1..17).to_a.sample }
    home_team_id  { SecureRandom.random_number(1e2.to_i) }
    away_team_id  { SecureRandom.random_number(1e2.to_i) }
    played_at     { Time.now }
  end

  factory :user do
    uid               { SecureRandom.hex }
    provider          { "facebook" }
    email             { Forgery(:internet).email_address }
    sign_in_count     { SecureRandom.random_number(1e1.to_i) }
    last_sign_in_at   { Time.now }
    teams             { [FactoryGirl.build(:team)] }
  end

  factory :prediction do
    game_id             { SecureRandom.random_number(1e7.to_i) }
    winning_team_id     { SecureRandom.random_number(1e6.to_i) }
    losing_team_id      { SecureRandom.random_number(1e5.to_i) }
    winning_team_score  { 26 }
    losing_team_score   { 17 }
    forecast_id         { SecureRandom.random_number(1e4.to_i) }
  end

  factory :forecast do
    title           { "Training Camp Edition" }
    user_id         { SecureRandom.random_number(1e6.to_i) }
  end
end