# frozen_string_literal: true

desc 'Open project console'
task :console do
  exec "sh -c 'MONGOID_ENV=development bundle exec bin/console'"
end
