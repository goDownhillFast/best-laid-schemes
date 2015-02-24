Planner::Application.routes.draw do

  scope :module => 'api' do

  end

  root :to => 'sessions#welcome'

  match "/signout"      => "sessions#destroy", :as => :signout

  get '/budget'         => 'budget#index',    :as => 'budget'
  get   '/manage'       => 'manage#index',    :as => 'manage'
  post  '/manage'       => 'manage#create',   :as => 'create_category'
  put  '/manage/:id'    => 'manage#update',   :as => 'update_category'
  get '/manage/:id'     => 'manage#edit',     :as => 'category'
  delete '/manage/:id'  => 'manage#delete',   :as => 'delete_category'

  get '/plan'           => 'plan#index',      :as => 'plan_index'
  get '/plan/new'       => 'plan#new',        :as => 'new_activity'
  post '/plan'          => 'plan#create',     :as => 'create_activity'
  put '/plan/:id'       => 'plan#update',     :as => 'update_activity'
  get '/plan/:id/edit'  => 'plan#edit',       :as => 'edit_activity'
  delete 'plan/:id'     => 'plan#delete',     :as => 'activity'

  resources :users

  resources :sessions do
    collection do
      post 'login', :action => 'create'
    end
  end

  match "/auth/:provider/callback" => "sessions#create"

end
