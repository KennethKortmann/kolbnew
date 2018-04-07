Rails.application.routes.draw do
  get '/', to: 'questionnaire#index'
  post '/participate', to: 'participations#participate'
  get 'results/', to: 'results#index'
  get 'result/:id', to: 'results#detail'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
