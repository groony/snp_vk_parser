# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'snp_vk_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'snp_vk_api'
  spec.version       = SnpVkApi::VERSION
  spec.authors       = ['Ivan Novikov']
  spec.email         = ['ivan.novikov@saltpepper.ru']

  spec.summary       = 'SNP VK API allows you some awesome features'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.add_dependency 'vkontakte-api', '~> 1.4'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'factory_girl', '~> 4.0'
end
