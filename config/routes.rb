Rails.application.routes.draw do
  devise_for :users
  
  # Nested routes: Bugs always belong to a project visually
  resources :projects do
    resources :bugs
  end

  # Sets the main page of your website to the list of projects
  root "projects#index"
end