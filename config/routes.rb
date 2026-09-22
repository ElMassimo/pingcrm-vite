Rails.application.routes.draw do
  defaults export: true do
    devise_for :users, skip: [:sessions, :passwords, :registrations]
    as :user do
      get "login", to: "users/sessions#new", as: :new_user_session
      post "login", to: "users/sessions#create", as: :user_session
      match "logout", to: "users/sessions#destroy", as: :destroy_user_session, via: Devise.mappings[:user].sign_out_via
    end

    resources :reports, only: [:index]

    resources :users, except: [:show] do
      put :restore, on: :member
    end

    resources :organizations, except: [:show, :new] do
      put :restore, on: :member
    end

    resources :contacts, except: [:show] do
      put :restore, on: :member
    end

    root "dashboard#index"
  end
end
