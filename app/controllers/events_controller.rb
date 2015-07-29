class EventsController < ApplicationController
  def index
  end

  def new
  end

  def create
    Service::Mailgun::EmailSongApprovalProxy
    .new(@dj,@listener_song_request)
    .send!
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
