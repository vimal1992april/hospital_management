Rails.application.routes.draw do
  get 'profiles/show'
  get 'profiles/update'
  get 'appointments/index'
  get 'appointments/show'
  get 'appointments/new'
  get 'appointments/edit'
  get 'patients/index'
  get 'patients/show'
  get 'patients/new'
  get 'patients/edit'
  get 'home/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root "home#index"
  resources :patients, only: [:index, :show, :new, :create]
  resources :appointments, only: [:index, :new, :create, :destroy]
  resource :profile, only: [:show, :update] # Single profile per user

end
