require 'rack'
require 'thread'
require './forwarder'

module Dockermon
  class HTTPServer
    attr_reader :port, :thread

    def initialize(port = 80)
      @port = port
    end

    def start
      @thread = Thread.new { Rack::Handler::WEBrick.run Dockermon::Forwarder.new, Port: port }
    end

    def stop
      thread.exit
    end
  end
end
