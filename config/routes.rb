Rails.application.routes.draw do
  namespace :admin do
    root 'page#index'
    match 'login', controller: :page, action: :login, via: [:get, :post]
    get 'logout', controller: :page, action: :logout

    [:admin_users].each do |sym|
      resources sym
    end
  end



  namespace :company do
    root 'users#index'
    match 'login', controller: :page, action: :login, via: [:get, :post]
    get 'logout', controller: :page, action: :logout
    [:questions].each do |sym|
      resources sym
    end
  end

  post '/webhook', controller: 'api/message', action: :webhook
end
