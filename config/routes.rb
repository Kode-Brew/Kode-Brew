Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resources :clients do
    resources :projects, only: [:index] # não há necessidade de todas routes de projects embedadas em client
  end


  resources :projects do
    resources :sprints, only: %i[index new create] do
      resources :tasks, only: %i[new create]
      resources :sprint_lectures, only: %i[new create index]
    end
    resources :project_members, except: %i[update destroy]
    member do
      post 'advance_sprint'
      post 'finish_project'
    end
  end

  resources :sprints, only: %i[show edit update destroy]

  resources :tasks, only: %i[show edit update destroy]

  resources :project_members, only: %i[update destroy]

  resources :projects, only: %i[show edit update destroy]

  get "myprojects" => 'projects#myprojects'
  get "dashboard" => 'projects#dashboard'
  # resources :project_members

  resources :sprint_lectures, only: %i[show edit update destroy]
  resources :lectures
  resources :tickets
  # Defines the root path route ("/")
  # root "posts#index"
end
