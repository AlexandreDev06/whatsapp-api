require 'sidekiq/web'

Rails.application.routes.draw do
  resources :api, only: [] do
    collection do
      mount Sidekiq::Web => '/sidekiq'

      resource :auths, only: [] do
        post 'create_token'
      end

      resource :wpp_sessions, only: [] do
        post 'create_session'
        get 'status_session'
      end
    end
  end
end
