source 'https://rubygems.org'

gem 'berkshelf', '~>2.0'
gem 'chef', '~> 11.6'

group :style do
  gem 'foodcritic', '~>3.0'
  gem 'rubocop'
end

group :unit do
  gem 'chefspec', '~>3.0'
  gem 'rspec'
  gem 'fuubar'
end

group :integration do
  gem 'kitchen-vagrant', '~>0.11'
  gem 'test-kitchen', '>=1.1.0'
end

group :development do
  gem 'guard'
  gem 'guard-kitchen'
  gem 'guard-rspec'
  gem 'rake'
end
