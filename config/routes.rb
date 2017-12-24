Rails.application.routes.draw do

  resources :sessions, only: [:new, :create,:show, :destroy]
  resources :users, only: [:new, :create,:show]
  resources :favorites, only: [:create, :destroy, :index]

  get 'blogs/top'
  root :to => 'blogs#top'
  
  resources :blogs, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    collection do
      post :confirm
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
