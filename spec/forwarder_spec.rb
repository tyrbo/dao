require 'spec_helper'

describe Dao::Forwarder do
  describe '#rewrite_env' do
    it 'returns the proper address for a given host' do
      hash = { 'HTTP_HOST' => '192.168.59.103:1337' }

      allow(Dao::PortMapper).to receive(:get_addr_for).and_return('192.168.59.103:1337')
      expect(Dao::Forwarder.new.rewrite_env({})).to eq hash
    end
  end
end
