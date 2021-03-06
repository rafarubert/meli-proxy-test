# frozen_string_literal: true

require 'rspec'
require 'json'

require File.expand_path('lib/meli_proxy')

require 'simplecov'
require 'database_cleaner-mongoid'

SimpleCov.start do
  add_filter '/spec/'
end

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner[:mongoid].strategy = [:deletion]
  end

  config.before do
    DatabaseCleaner[:mongoid].start
  end

  config.after do
    DatabaseCleaner[:mongoid].clean
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
