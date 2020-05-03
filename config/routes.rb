Rails.application.routes.draw do
  devise_for :users
  root to: 'todo_lists#index'

  resources :todo_lists, except: %i[new edit] do
    resources :tasks, shallow: true, only: %i[create update destroy]
  end
end
