Rails.application.routes.draw do
  resources :tutors, only: [:index, :show ,:create]
  resources :courses, only: [:index, :show, :create]
end
