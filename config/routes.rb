Rails.application.routes.draw do
  namespace :admin do
    root 'page#index'
    match 'login', controller: :page, action: :login, via: [:get, :post]
    get 'logout', controller: :page, action: :logout

    [:admin_users].each do |sym|
      resources sym
    end
  end
end
