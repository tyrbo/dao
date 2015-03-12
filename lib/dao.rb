require 'rubygems'
require 'bundler/setup'

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
          ip = get_ip_from_vm('dao-dev') || exit!
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

    def get_ip_from_vm(name)
      ip = `docker-machine ip #{name}`.strip

      if ip =~ /^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$/
        ip
      end
    end
  end
end
