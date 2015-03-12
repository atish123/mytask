Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "user/registrations"}

  
  root to: "home#index" #root page
  	
resources :home, only: [:show]

  get 'dashboard' => 'dashboard#index'
  get "admin/users/:id/delete" => "users#destroy"
  get "admin/users/:id/unblock" => "users#unblock"
  get "admin/users/:id/block" => "users#block"
    scope '/admin' do
    resources :users
      end
 
end
