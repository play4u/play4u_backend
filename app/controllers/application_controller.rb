require 'log4r'

class ApplicationController < ActionController::Base
  before_action :set_logger
  
  protected
  def set_logger
    @logger=Log4r::Logger['controller']
  end
end
