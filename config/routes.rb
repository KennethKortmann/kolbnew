Rails.application.routes.draw do
  post '/participate', to: 'participations#participate'
  get '/', to: 'questionnaire#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
