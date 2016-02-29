Rails.application.routes.draw do
  get 'status' => 'status#index'
  post 'status/create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  # devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  root 'welcome#index'
end
