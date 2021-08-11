# frozen_string_literal: true
ENV['APP_ENV'] ||= 'development'

require 'bundler/setup'
require 'dotenv/load'

require 'mongoid'
require 'zeitwerk'

require 'yaml'

require File.join(File.expand_path('../', __dir__), 'config', 'envirorments', "#{ENV['APP_ENV']}.rb")

module MeliProxy
  configs = YAML.load_file(File.join(File.expand_path('../', __dir__), 'config', 'config.yml'))

  MeliProxy::MAX_IP = configs['meli-proxy']['max_ip']
  MeliProxy::MAX_PATH = configs['meli-proxy']['max_path']
  MeliProxy::MAX_IP_PATH = configs['meli-proxy']['max_ip_path']
  MeliProxy::REDIRECT_URL = configs['meli-proxy']['redirect_url']
end

Mongoid.load!(File.join(File.expand_path('../', __dir__), 'config', 'mongoid.yml'))

loader = Zeitwerk::Loader.new

%w[entities errors repositories services validations vo].each do |dir|
  loader.push_dir("#{File.expand_path('./meli_proxy', __dir__)}/#{dir}")
end

loader.setup
