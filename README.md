h1. Rdebug-ide Test::Unit support for Spork

This includes a plugin for spork to enable running Test::Unit tests through rdebug-ide for use through the RubyMine debugger

To use it, install the gem, then fire up spork in your project directory.

Then, once spork is running, invoke add `-S dtestdrb` to the ruby args for your rubymine run configuration
