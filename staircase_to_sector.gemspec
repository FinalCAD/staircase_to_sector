
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "staircase_to_sector/version"

Gem::Specification.new do |spec|
  spec.name          = "staircase_to_sector"
  spec.version       = StaircaseToSector::VERSION
  spec.authors       = ["Joel AZEMAR"]
  spec.email         = ["joel.azemar@gmail.com"]

  spec.summary       = %q{A lib to compose files}
  spec.description   = %q{A lib to compose files}
  spec.homepage      = "https://github.com/FinalCAD/staircase_to_sector"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://gem.fury.io/finalcad"
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
end
