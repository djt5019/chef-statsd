require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'foodcritic'
require 'kitchen'

SafeYAML::OPTIONS[:default_mode] = :safe

desc "Run RSpec unit tests"
RSpec::Core::RakeTask.new('unit-test')

desc "Run linting utilities"
task "lint" => [:foodcritic, :rubocop]

FoodCritic::Rake::LintTask.new
Rubocop::RakeTask.new

desc "Remove generated content"
task "maintainer-clean" do
  sh %q{kitchen destroy --parallel}
  sh %q{vagrant destroy -f}
  rmtree ".kitchen"
  rmtree ".vagrant"
  rmtree "tmp"
  rmtree "vendor"
end

desc "Run integration tests."
task "integration-test" do
  config = Kitchen::Config.new
  config.instances.each do |instance|
      instance.test :always
  end
end

task 'test' => ['unit-test', 'integration-test', 'lint']
