require 'dao/version'
require 'dns_server'
require 'port_mapper'
require 'http_server'
require 'containers'

module Dao
  class Base
    attr_reader :containers, :servers

    def initialize
      @containers = Dao::Containers.new
      @servers = []
    end

    def run
      Dao::DNSServer.new(5300).start

      loop do
        begin
          ip = `docker-machine ip ls-dev`.strip # gross.
          old_ports = servers.map(&:port)
          mappings = Dao::PortMapper.create(ip, containers.matching)

          mappings.each do |port, _|
            if servers.none? { |x| x.port == port }
              @servers << Dao::HTTPServer.new(port).start
            end
          end

          new_ports = mappings.map { |port, _| port }
          stale_ports = old_ports - new_ports

          stale_ports.each do |port|
            idx = servers.find_index { |s| s.port == port }
            servers.delete_at(idx).stop
          end

          sleep 15
        rescue => e
          puts e
          sleep 15
        end
      end
    end
  end
end
