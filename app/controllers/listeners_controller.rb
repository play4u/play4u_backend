class ListenersController < ApplicationController
  include PeopleController
  LISTENER_NOT_FOUND_ERROR_MESSAGE='Listener not found'
  
  def destroy
    if @person
      @person.destroy
      render_person
    else
      render plain: LISTENER_NOT_FOUND_ERROR_MESSAGE, :status => :internal_server_error
    end
  end
  
  def define_person
     @person=Listener
    .where(first_name: params[:first_name])
    .first_or_create!
  end
  
  def render_person
    render json: {listener: @person}
  end
  
  def update
    if @person
      @person.first_name=params[:first_name] if params[:first_name].present?
      @person.email=params[:email] if params[:email].present?
      @person.save!
      render json: {person: @person}
    else
      render plain: LISTENER_NOT_FOUND_ERROR_MESSAGE, :status => :internal_server_error
    end
  end
  
  def show
    if @person
      render_person
    else
      render plain: LISTENER_NOT_FOUND_ERROR_MESSAGE, :status => :internal_server_error
    end
  end
end
