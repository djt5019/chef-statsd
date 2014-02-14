require 'chefspec'
require 'chefspec/berkshelf'
require 'safe_yaml'

SafeYAML::OPTIONS[:default_mode] = :safe
SafeYAML::OPTIONS[:deserialize_symbols] = true

RSpec.configure do |config|
  # See http://code.sethvargo.com/chefspec/#configuration
  config.platform = 'ubuntu'
  config.version = '12.04'
end

def create_chef_runner
  ChefSpec::Runner.new do |node|
    yield node if block_given?
  end
end

def start_runit_service(service)
  ChefSpec::Matchers::ResourceMatcher.new(:runit_service, :start, service)
end
