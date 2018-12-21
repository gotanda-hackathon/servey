Rails.application.routes.draw do
  devise_for :customers, controllers: {
    sessions:       'customers/sessions',
    passwords:      'customers/passwords',
    registrations:  'customers/registrations'
  }
  root 'pages#index'
  get 'pages/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
