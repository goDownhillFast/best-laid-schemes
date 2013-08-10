Planner::Application.routes.draw do

  root :to => 'sessions#welcome'

  resources :users
  resources :activities
  resources :tasks
  resources :weekly_plans
  resources :categories
  resources :calendars

  resources :sessions do
    collection do
      post 'login', :action => 'create'
    end
  end

  match "/auth/:provider/callback" => "sessions#create"

end
