require_relative "#{Rails.root}/app/app_config/web_settings"

Rails.application.routes.draw do
  post 'listener_requests/request_song'

  get AppConfig::WebSettings.email_song_request_route, 
  to: 'emails#generate_song_request'
   
end
