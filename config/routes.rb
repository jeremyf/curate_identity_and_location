CurateIdentityAndLocation::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  namespace :curate do
    resources :deposits
  end
end