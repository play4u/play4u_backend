require_relative "#{Rails.root}/app/app_config/web_settings"

Rails.application.routes.draw do
  resources :music_jockeys do
    resources :reservations, except: [:new, :edit]
  end
  
  resources :music_jockeys, except: [:new, :edit]
  resources :listeners, except: [:new, :edit]

  post '/artists/:artist_name/songs/:song_name/request', to: 'listener_requests#request_song'
end
