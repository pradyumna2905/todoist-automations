Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  devise_scope :user do
    unauthenticated :user do
      root to: "authentications#new"
    end

    authenticated :user do
      root to: "automations#index", as: :authenticated_root
    end

    # delete "sign_out", to: "devise/sessions#destroy", as: :destroy_user_session
  end

  post "automation/enable", to: "enabled_automations#create"
  resources :enabled_automations, only: [] do
    resources :projects, only: [:create]
  end

  post "incoming_webhooks/todoist", to: "incoming_webhooks/todoists#create"

  mount Vocab::Engine, at: "/vocab-builder"
end
