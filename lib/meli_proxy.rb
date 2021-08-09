# frozen_string_literal: true

require 'bundler/setup'

require 'mongoid'
require 'zeitwerk'

Mongoid.load!(File.join(File.expand_path('../', __dir__), 'config', 'mongoid.yml'))

loader = Zeitwerk::Loader.new

%w[entities errors repositories services validations].each do |dir|
  loader.push_dir("#{File.expand_path('./meli_proxy', __dir__)}/#{dir}")
end

loader.setup