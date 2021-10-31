# frozen_string_literal: true

require_relative "lib/yamls/version"

Gem::Specification.new do |spec|
  spec.name          = "yamls"
  spec.version       = Yamls::VERSION
  spec.authors       = ["TsuMakoto"]
  spec.email         = ["tsukamoto@fusic.co.jp"]

  spec.summary       = "Managed Strong Parameters with yaml file."
  spec.homepage      = "https://github.com/TsuMakoto/yamls"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.8")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/TsuMakoto/yamls"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
