ENV["RAILS_ENV"] ||= 'test'
require 'rails/all'
require 'rspec/rails'

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = "random"
end

