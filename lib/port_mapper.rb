module Dao
  class PortMapper
    def self.create(ip, containers)
      @mappings = {}
      @ip = ip

      containers.each do |container|
        info = container.info
        ports = get_ports_for(info)
        name = get_name_for(info)

        ports.each do |port|
          public_port = port['PublicPort']
          private_port = port['PrivatePort']

          @mappings[private_port] ||= []
          @mappings[private_port] << { name: name, public_port: public_port, ip: @ip }
        end
      end

      @mappings
    end

    def self.get_name_for(info)
      name = info['Names'].first
      /^\/([A-z0-9]+?)_.*?_\d+/.match(name)[1]
    end

    def self.get_ports_for(info)
      ports = info['Ports'].select { |p| p['PublicPort'] }
    end

    def self.get_addr_for(req)
      name = req.host.split('.')[0]
      port = req.port
      priv_port = @mappings[port].detect { |x| x[:name] == name }[:public_port]

      "#{@ip}:#{priv_port}"
    end
  end
end
