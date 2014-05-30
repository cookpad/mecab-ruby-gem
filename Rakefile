require "bundler/gem_tasks"
require 'rake/extensiontask'

Rake::ExtensionTask.new('mecab')

# Default task
task :default => :compile do
  load File.expand_path('../examples/test.rb', __FILE__)
end
