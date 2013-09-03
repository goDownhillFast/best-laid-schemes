Planner::Application.routes.draw do

  root :to => 'sessions#welcome'

  match '/budget'       => 'budget#index',    :as => 'budget'
  get   '/manage'       => 'manage#index',    :as => 'manage'
  post  '/manage'       => 'manage#create',   :as => 'create_category'
  get '/manage/:id'     => 'manage#edit',     :as => 'category'
  delete '/manage/:id'  => 'manage#delete',   :as => 'delete_category'
  
  resources :plan
  resources :users
  resources :tasks
  resources :weekly_plans
  resources :calendars

  resources :sessions do
    collection do
      post 'login', :action => 'create'
    end
  end

  match "/auth/:provider/callback" => "sessions#create"

end
