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
  resources :patients
  resources :appointments, only: [:index, :create, :destroy]
  get 'appointments/new/:patient_id', to: 'appointments#new', as: 'new_appointment_with_patient'

  resource :profile, only: [:show, :update] # Single profile per user

end
