Wishbone::Application.routes.draw do

  scope controller: 'games', constraints: { id: /[0-9]+/ } do
    match '/schedule' => :index, as: :schedule
    match '/games/:id' => :show, as: :game
  end
end
