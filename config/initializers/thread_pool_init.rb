require 'thread/pool'
require 'thread/channel'
require 'thread/pipe'
require 'thread/promise'

module AppConfig
  module Scalability
    THREAD_POOL=Thread.pool(AppConfig::Scalability.thread_pool_capacity)
  end
end