# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rake/extensiontask"

task build: :compile

Rake::ExtensionTask.new("graal_ext_rb_example") do |ext|
  ext.lib_dir = "lib/graal_ext_rb_example"
end

task default: %i[clobber compile spec]
