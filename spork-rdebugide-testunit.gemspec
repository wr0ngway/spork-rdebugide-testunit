# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spork-rdebugide-testunit/version"

Gem::Specification.new do |s|
  s.name        = "spork-rdebugide-testunit"
  s.version     = Spork::RdebugIdeTestUnit::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matt Conway"]
  s.email       = ["matt@conwaysplace.com"]
  s.homepage    = ""
  s.summary     = %q{Test Unit runner for spork with rdebug-ide integration (for rubymine)}
  s.description = %q{Test Unit runner for spork with rdebug-ide integration (for rubymine)}

  s.rubyforge_project = "spork-rdebugide-testunit"

  s.files         = %w{
                        Gemfile
                        Rakefile
                        bin/dtestdrb
                        lib/spork-rdebugide-testunit.rb
                        lib/spork-rdebugide-testunit/version.rb
                        lib/spork/test_framework/rdebug_ide_test_unit.rb
                        spork-rdebugide-testunit.gemspec
                      }
  s.test_files    = []
  s.executables   = ["dtestdrb"]
  s.require_paths = ["lib"]

  s.add_dependency("spork", '~> 0.9.0.rc3')
  s.add_dependency("spork-testunit", '~> 0.0.4')

end
