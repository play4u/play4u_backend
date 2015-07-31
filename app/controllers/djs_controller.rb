class DjsController < ApplicationController
  include PeopleController
  DJ_NOT_FOUND_ERROR_MESSAGE='DJ not found'
  
  def destroy
    if @person
      @person.destroy
      render_person
    else
      render plain: DJ_NOT_FOUND_ERROR_MESSAGE, :status => :internal_server_error
    end
  end
  
  def update
    if @person
      @person.stage_name=params[:stage_name] if params[:stage_name].present?
      @person.person_detail.email=params[:email] if params[:email].present?
      @person.person_detail.save!
      @person.save!
      render_person
    else
      render plain: DJ_NOT_FOUND_ERROR_MESSAGE, :status => :internal_server_error
    end
  end
  
  def define_person
    @person=Dj
    .where(stage_name: params[:stage_name])
    .first_or_initialize
  end
  
  def render_person
    render json: {dj: @person}
  end
  
  def show
    if @person
      render_person
    else
      render plain: DJ_NOT_FOUND_ERROR_MESSAGE, :status => :internal_server_error
    end
  end
end