require 'rubydns'

module Dao
  class DNSServer
    attr_reader :port, :interfaces

    def initialize(port = 5300)
      @port = port
      @interfaces = [
        [:udp, '127.0.0.1', port],
        [:tcp, '127.0.0.1', port]
      ]
    end

    def start
      RubyDNS::run_server(asynchronous: true, listen: interfaces) do
        match(/(.*?)\.dao$/, Resolv::DNS::Resource::IN::A) do |transaction|
          transaction.respond!('127.0.0.1')
        end
      end
    end
  end
end
