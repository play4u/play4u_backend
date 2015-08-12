module AppConfig
  module Scalability
    DEFAULT_THREAD_POOL_CAPACITY=3
    
    def self.thread_pool_capacity
      pool_size=ENV['THREAD_POOL_CAPACITY'].to_i.abs
      pool_size=DEFAULT_THREAD_POOL_CAPACITY if pool_size==0
      pool_size
    end
  end
end