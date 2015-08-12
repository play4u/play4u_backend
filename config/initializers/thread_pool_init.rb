require 'thread/pool'
require 'thread/channel'
require 'thread/pipe'
require 'thread/promise'
require "#{Rails.root}/app/app_config/scalability_settings"

module AppConfig
  module Scalability
    THREAD_POOL=Thread.pool(AppConfig::Scalability.thread_pool_capacity)
  end
end