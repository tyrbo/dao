require 'rack-proxy'

module Dao
  class Forwarder < Rack::Proxy
    def rewrite_env(env)
      req = Rack::Request.new(env)
      env['HTTP_HOST'] = PortMapper.get_addr_for(req)
      env
    end
  end
end
