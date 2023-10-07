# frozen_string_literal: true

require_relative "lib/graal_ext_rb_example/version"

Gem::Specification.new do |spec|
  spec.name = "graal_ext_rb_example"
  spec.version = GraalExtRbExample::VERSION
  spec.authors = ["shoma07"]
  spec.email = ["23730734+shoma07@users.noreply.github.com"]

  spec.summary = "Example of Ruby C Extension with GraalVM Native Image"
  spec.description = "Example of Ruby C Extension with GraalVM Native Image"
  spec.homepage = "https://github.com/shoma07/graal_ext_rb_example"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions = ["ext/graal_ext_rb_example/extconf.rb"]

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
