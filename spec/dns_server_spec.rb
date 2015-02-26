require 'spec_helper'

describe Dao::DNSServer do
  describe '#initialize' do
    it 'assigns interfaces' do
      dns_server = Dao::DNSServer.new
      interfaces = [
        [:udp, '127.0.0.1', 5300],
        [:tcp, '127.0.0.1', 5300]
      ]

      expect(dns_server.interfaces).to eq interfaces
    end

    it 'allows the port to be overridden' do
      dns_server = Dao::DNSServer.new(1234)

      expect(dns_server.port).to eq 1234
    end
  end
end
