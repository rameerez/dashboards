# frozen_string_literal: true

require_relative "lib/dashboards/version"

Gem::Specification.new do |spec|
  spec.name = "dashboards"
  spec.version = Dashboards::VERSION
  spec.authors = ["rameerez"]
  spec.email = ["rubygems@rameerez.com"]

  spec.summary = "A simple and powerful DSL for creating beautiful, customizable bento-style admin dashboards in Rails applications."
  spec.description = "Create beautiful, customizable bento-style admin dashboards in your Rails application with a very simple DSL."
  spec.homepage = "https://github.com/rameerez/dashboards"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/rameerez/dashboards"
  spec.metadata["changelog_uri"] = "https://github.com/rameerez/dashboards/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 7.0.0"
  spec.add_dependency "importmap-rails", "~> 2.0", ">= 2.0.0"
  spec.add_dependency "chartkick", "~> 5.0"
  spec.add_dependency "groupdate", "~> 6.1"

  spec.add_development_dependency "rspec", "~> 3.12"
  spec.add_development_dependency "rubocop", "~> 1.50"
end
