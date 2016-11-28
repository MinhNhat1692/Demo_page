Rails.application.routes.draw do
  post '/request', to: 'handle_request#regRequest'
  
  root "homepage#home"
  
  get '/services', to: 'homepage#services'

  get '/reg', to: 'homepage#reg'

  get '/result', to: 'homepage#result'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
