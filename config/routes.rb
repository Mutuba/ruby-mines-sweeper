# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }

  resources :games, only: %i[index new create update show] do
    resources :cells, only: [:update] do
      patch :flag, on: :member
    end
  end

  root 'games#index'
end
