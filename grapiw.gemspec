lib = File.expand_path("../lib", __FILE__)
$:.unshift lib unless $:.include? lib

require("grapiw/version")

Gem::Specification.new do |s|
  s.name        = "grapiw"
  s.version     = Grapiw::VERSION
  s.authors     = ["Chris McGrath"]
  s.email       = ["mcgrath.chris@gmail.com"]
  s.homepage    = %q{http://github.com/phiction/grapiw}
  s.summary     = %q{Ruby wrapper for Google Reader APIs}
  s.description = %q{Summary - Ruby wrapper for Google Reader APIs}
  
  s.add_dependency("nokogiri", "~> 1.4.4")
  s.add_dependency("rest-client", "~> 1.6")
  s.add_dependency("json", "~> 1.5.3")
  
  s.add_development_dependency("rspec", "~> 2.6")
  s.add_development_dependency("mocha", "~> 0.9.12")
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = Dir.glob("spec/**/*.rb")
  s.require_path  = "lib"
end
