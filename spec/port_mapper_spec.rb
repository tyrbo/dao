require 'spec_helper'

describe Dao::PortMapper do
  describe '.get_name_for' do
    it 'returns the name for a given container' do
      container = FakeContainer.new(['/thename_app_1'])
      expect(Dao::PortMapper.get_name_for(container.info)).to eq 'thename'
    end
  end

  describe '.get_ports_for' do
    it 'returns the public ports for a given container' do
      container = FakeContainer.new([], [{'PrivatePort' => 6366}, {'PrivatePort' => 9292, 'PublicPort' => 9292}])
      expect(Dao::PortMapper.get_ports_for(container.info)).to eq [{'PrivatePort' => 9292, 'PublicPort' => 9292}]
    end
  end
end
