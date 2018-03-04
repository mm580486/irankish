
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "irankish/version"

Gem::Specification.new do |spec|
  spec.name          = "irankish"
  spec.version       = Irankish::VERSION
  spec.authors       = ["mohammad mahmoodi"]
  spec.email         = ["mm580486@gmail.com"]

  spec.summary       = "payment gem"
  spec.description   = "a gem for transaction"
  spec.homepage      = "https://github.com/mm580486/irankish"
  spec.license       = "WTTF"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'savon', ['~> 2.0']
  spec.add_dependency "validatable",'~> 1.6'
  spec.add_development_dependency "bundler", "~> 1.16.a"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
