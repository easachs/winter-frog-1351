Rails.application.routes.draw do

  get '/plots', to: 'plots#index'
  get '/plots/:id', to: 'plants#index'
  get '/gardens/:id', to: 'gardens#show'
  delete '/plots/:id/plants/:id', to: 'plots#destroy'

end
