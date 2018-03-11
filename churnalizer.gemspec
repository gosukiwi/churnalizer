
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "churnalizer/version"

Gem::Specification.new do |spec|
  spec.name          = "churnalizer"
  spec.version       = Churnalizer::VERSION
  spec.authors       = ["Federico Ramirez"]
  spec.email         = ["federico_r@beezwax.net"]

  spec.summary       = %q{Analyze your Ruby application for Churn vs Complexity}
  spec.homepage      = "http://github.com/gosukiwi/churnalizer"

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rb-readline"

  spec.add_dependency "flog"
end
