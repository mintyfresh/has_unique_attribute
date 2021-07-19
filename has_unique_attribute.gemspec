# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'has_unique_attribute/version'

Gem::Specification.new do |spec|
  spec.name     = 'has_unique_attribute'
  spec.version  = HasUniqueAttribute::VERSION
  spec.authors  = ['Minty Fresh']
  spec.email    = []
  spec.licenses = ['MIT']

  spec.summary     = 'Handle unique attributes safely using the database.'
  spec.description = 'Adds custom handling for database uniqueness constraints to ActiveRecord.'
  spec.homepage    = 'https://github.com/mintyfresh/has_unique_attribute'

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/mintyfresh/has_unique_attribute'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.88'
  spec.add_development_dependency 'rubocop-performance', '~> 1.7'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.42'
end
