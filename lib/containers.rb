require 'docker'

module Dao
  class Containers
    def initialize
      Excon.defaults[:ssl_verify_peer] = false
    end

    def matching
      containers = Docker::Container.all.select do |c|
        c.info['Names'].any? { |n| n =~ /^\/([A-z0-9]+?)_.*?_\d+/ }
      end
    end
  end
end
