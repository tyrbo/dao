require 'rack'
require 'thread'
require 'forwarder'
require 'rack/handler/puma'

module Dao
  class HTTPServer
    attr_reader :port, :thread

    def initialize(port = 80)
      @port = port
    end

    def start
      @thread = Thread.new { Rack::Handler::Puma.run Dao::Forwarder.new, Port: port }
      self
    end

    def stop
      thread.exit
    end
  end
end
