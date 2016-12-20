Rails.application.routes.draw do
  apipie
  resources :posts, except: [:new, :edit]
  post 'user_token' => 'user_token#create'
end
