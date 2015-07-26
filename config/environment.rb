# Load the Rails application.
require File.expand_path('../application', __FILE__)
require 'log4r'
require 'log4r/yamlconfigurator'

Log4r::YamlConfigurator.load_yaml_file(File.expand_path('../log4r.yml', __FILE__))

# Initialize the Rails application.
Rails.application.initialize!