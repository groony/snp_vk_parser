$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'snp_vk_api'
require 'vcr'
require 'webmock/rspec'
require 'factory_girl'
require_relative 'factories.rb'
Dir["#{Dir.pwd}/spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.expect_with :rspec do |c|
    c.syntax = :should
  end
end

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = 'spec/support/cassettes'
  c.configure_rspec_metadata!
  c.default_cassette_options = { re_record_interval: (3600 * 24) }
end
