require 'dao'

class FakeContainer
  def initialize(names, ports = [])
    @names = names
    @ports = ports
  end

  def info
    { 'Names' => @names, 'Ports' => @ports }
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
