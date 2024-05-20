Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resources :clients do
    resources :projects
  end

  # Be: aceitei a minha modificação de rota, não 'embedei' o sprints dentro de clients/projects, mas não sei qual o caminho correto.

  resources :projects do
    resources :sprints, only: [:index, :new, :create]
  end

  resources :sprints, only: [:show, :edit, :update, :destroy]

  resources :projects
  resources :project_members

  resources :sprint_lectures
  resources :lectures
  resources :tasks
  resources :tickets
  # Defines the root path route ("/")
  # root "posts#index"
end
