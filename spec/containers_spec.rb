require 'spec_helper'

describe Dao::Containers do
  describe '#initialize' do
    it 'sets Excon defaults to not verify peer for ssl' do
      Dao::Containers.new

      expect(Excon.defaults[:ssl_verify_peer]).to be false
    end
  end

  describe '#matching' do
    it 'returns containers with fig style names' do
      arr = [FakeContainer.new(['/dao_app_1', '/dao_mysql_1']),
             FakeContainer.new(['/notvalid']),
             FakeContainer.new(['/notvalid', '/with_valid_1'])]

      allow(Docker::Container).to receive(:all).and_return(arr)
      expect(Dao::Containers.new.matching.count).to eq 2
    end
  end
end
