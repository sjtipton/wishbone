Wishbone::Application.routes.draw do

  scope controller: 'games', constraints: { id: /[0-9]+/ } do
    match '/schedule' => :index, as: :schedule
    match '/games/:id' => :show, as: :game
  end

  scope controller: 'team_games', constraints: { id: /[0-9]+/ } do
    match '/teams/:id/schedule' => :index, as: :team_schedule
  end

  scope controller: 'teams', constraints: { id: /[0-9]+/ } do
    match '/teams' => :index, as: :teams
    match '/teams/:id' => :show, as: :team
  end

  # Omniauth Facebook routes
  scope controller: 'sessions', constraints: { provider: /facebook/ } do
    match '/auth/:provider/callback' => :authenticate_user, as: :omniauth_callback
    match '/auth/failure' => :failure, as: :omniauth_failure
  end
end
