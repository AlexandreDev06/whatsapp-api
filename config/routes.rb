require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'application#welcome'

  resources :api, only: [] do
    collection do
      mount Sidekiq::Web => '/sidekiq'

      resource :auths, only: [] do
        post 'create_token'
      end

      resource :wpp_sessions, only: [] do
        post 'create_session'
        get 'status_session'
        post 'close_session'
      end

      resource :messages, only: [] do
        post 'send_message'
      end
    end
  end
end
