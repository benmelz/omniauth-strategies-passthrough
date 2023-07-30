# frozen_string_literal: true

require_relative 'lib/omniauth/strategies/passthrough/version'

Gem::Specification.new do |spec|
  spec.name = 'OmniAuth-strategies-passthrough'
  spec.summary = 'A development OmniAuth strategy that passes POST request params through to OAuth callbacks.'
  spec.description = <<~DESCRIPTION.tr("\n", ' ') # TODO
  DESCRIPTION
  spec.license = 'MIT'
  spec.author = 'Benjamin Melz'
  spec.email = ['ben@melz.me']
  spec.homepage = 'https://github.com/benmelz/omniauth-strategies-passthrough'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/v#{OmniAuth::Strategies::Passthrough::VERSION}/CHANGELOG.md"
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir['lib/**/*', 'CHANGELOG.md', 'README.md', 'LICENSE.md']
  spec.require_path = 'lib'

  spec.version = OmniAuth::Strategies::Passthrough::VERSION
  spec.required_ruby_version = '>= 3.0'
end
