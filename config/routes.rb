Rails.application.routes.draw do
   get AppConfig::WebSettings.email_song_request_route, 
   to: 'emails#generate_song_request'
end
