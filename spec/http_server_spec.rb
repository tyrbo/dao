require 'spec_helper'

describe Dao::HTTPServer do
  describe '#initialize' do
    it 'sets a default port' do
      http = Dao::HTTPServer.new
      
      expect(http.port).to eq 80
    end

    it 'allows the port to be overridden' do
      http = Dao::HTTPServer.new(1024)

      expect(http.port).to eq 1024
    end
  end

  describe '#start' do
    it 'creates a new thread' do
      http = Dao::HTTPServer.new(6000)

      http.start

      expect(http.thread).to be_a Thread
      expect(http.thread.alive?).to be true
    end
  end

  describe '#stop' do
    it 'exits the thread' do
      http = Dao::HTTPServer.new(6000)

      http.start
      http.stop
      http.thread.join

      expect(http.thread.alive?).to be false
    end
  end
end
