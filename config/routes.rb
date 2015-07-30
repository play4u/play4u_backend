require_relative "#{Rails.root}/app/app_config/web_settings"

Rails.application.routes.draw do
  resources :djs do
    resources :reservations
  end

  get AppConfig::WebSettings.email_song_request_route, 
  to: 'emails#generate_song_request'
   
  get AppConfig::WebSettings.email_song_approve_route, 
  to: 'emails#generate_song_approve'
  
  get AppConfig::WebSettings.email_cancel_reservation_route, 
  to: 'emails#generate_cancel_reservation'
  
  get AppConfig::WebSettings.email_update_reservation_route, 
  to: 'emails#generate_update_reservation'
end
