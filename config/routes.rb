Rails.application.routes.draw do
   get '/emails/song/request', to: 'emails#generate_song_request'
end
