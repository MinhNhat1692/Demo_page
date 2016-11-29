Rails.application.routes.draw do
  post '/request', to: 'homepage#post_reg'
  
  root "homepage#home"
  
  get '/services', to: 'homepage#services'

  get '/reg', to: 'homepage#reg'

  get '/result', to: 'homepage#result'

  resources :apikeys, only: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
