require_relative 'spec_helper'
require 'json'

CONFIG = JSON.pretty_generate(
  "graphitePort" => 2003,
  "graphiteHost" => "127.0.0.1",
  "address" => "0.0.0.0",
  "port" => 8125,
  "flushInterval" => 10000,
  "percentThreshold" => 90,
  "deleteIdleStats" => false,
  "deleteGauges" => false,
  "deleteTimers" => false,
  "deleteSets" => false,
  "deleteCounters" => false,
  "graphite" => {
    "legacyNamespace" => true,
    "globalPrefix" => "stats",
    "prefixCounter" => "counters",
    "prefixTimer" => "timers",
    "prefixGauge" => "gauges",
    "prefixSet" => "sets"
  }
)

describe 'statsd::default' do

  subject(:runner) { create_chef_runner.converge described_recipe }

  context 'Including recipes' do
    it { should include_recipe 'git' }
    it { should include_recipe 'nodejs' }
    it { should include_recipe 'runit' }
  end

  context 'Creating assets' do
    it 'should sync the remote git repo' do
      expect(runner).to sync_git('/usr/share/statsd').with(
        repository: 'https://github.com/etsy/statsd.git',
        reference: 'master',
        action: [:sync],
      )
    end

    it { should create_directory '/etc/statsd' }
    it { should render_file('/etc/statsd/config.js').with_content(CONFIG) }
    it { should create_user('statsd').with(system: true, shell: '/bin/false') }
    it 'should start the statsd runit service' do
      expect(runner).to start_runit_service('statsd').with(default_logger: true, options: {
        :user => 'statsd',
        :statsd_dir => '/usr/share/statsd',
        :conf_dir => '/etc/statsd',
        :nodejs_dir => '/usr/local'
      })
    end
  end
end
