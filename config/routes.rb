Wishbone::Application.routes.draw do

  root to: "home#index"
  get '/authentication_menu' => "home#authentication_menu", as: :authentication_menu

  scope controller: 'games', constraints: { id: /[0-9]+/ } do
    get '/schedule' => :index, as: :schedule
    get '/games/:id' => :show, as: :game
  end

  scope controller: 'team_games', constraints: { id: /[0-9]+/ } do
    get '/teams/:id/schedule' => :index, as: :team_schedule
  end

  scope controller: 'teams', constraints: { id: /[0-9]+/ } do
    get '/teams' => :index, as: :teams
    get '/teams/:id' => :show, as: :team
  end

  # Omniauth Facebook routes
  scope controller: 'sessions', constraints: { provider: /facebook/ } do
    match '/auth/:provider/callback' => :authenticate_user, as: :omniauth_callback
    match '/auth/failure' => :failure, as: :omniauth_failure
    get '/sign_out' => :destroy, as: :user_signout
  end
end
