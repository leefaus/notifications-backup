Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  destroy_user_session DELETE /users/sign_out(.:format)
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  root 'welcome#index'
end
