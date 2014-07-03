Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users
  resource :credentials
  resource :aux_leads

  # OAuth
  get '/authorize', to: 'credentials#authorize', :as => 'authorize'
  get '/callback', to: 'credentials#callback', :as => 'callback'
end
