require "ruby-debug-base"
require "ruby-debug-ide"
require "spork/test_framework/test_unit"

class Spork::TestFramework::RdebugIdeTestUnit < Spork::TestFramework::TestUnit

  def run_tests(argv, stderr, stdout)
    setup_rdebug(argv) do
      super(argv, stderr, stdout)
    end
  rescue => e
    puts "-"*30
    puts "Error executing #{argv.join(' ')}"
    puts e.message
    puts e.backtrace
    puts "-"*30
  end

  def setup_rdebug(argv)

    if argv.grep(/rdebug-ide/).size > 0

      while argv.shift !~ /rdebug-ide/; end

      options = OpenStruct.new(
        'frame_bind'  => false,
        'host'        => nil,
        'load_mode'   => false,
        'port'        => 1234,
        'stop'        => false,
        'tracing'     => false
      )

      opts = OptionParser.new do |opts|
        opts.banner = <<-EOB
          Using ruby-debug-base #{Debugger::VERSION}
          Usage: rdebug-ide is supposed to be called from RDT, NetBeans or RubyMine. The
                 command line interface to ruby-debug is rdebug.
        EOB
        opts.separator ""
        opts.separator "Options:"
        opts.on("-h", "--host HOST", "Host name used for remote debugging") {|host| options.host = host}
        opts.on("-p", "--port PORT", Integer, "Port used for remote debugging") {|port| options.port = port}
        opts.on('--stop', 'stop when the script is loaded') {options.stop = true}
        opts.on("-x", "--trace", "turn on line tracing") {options.tracing = true}
        opts.on("-l", "--load-mode", "load mode (experimental)") {options.load_mode = true}
        opts.on("-d", "--debug", "Debug self - prints information for debugging ruby-debug itself") do
          Debugger.cli_debug = true
        end
        opts.on("--xml-debug", "Debug self - sends information <message>s for debugging ruby-debug itself") do
          Debugger.xml_debug = true
        end
        opts.on("-I", "--include PATH", String, "Add PATH to $LOAD_PATH") do |path|
          $LOAD_PATH.unshift(path)
        end

        opts.on("--keep-frame-binding", "Keep frame bindings") {options.frame_bind = true}
        opts.separator ""
        opts.separator "Common options:"
        opts.on_tail("-v", "--version", "Show version") do
          puts "Using ruby-debug-base #{Debugger::VERSION}"
          exit
        end
      end

      begin
        opts.parse! argv
      rescue StandardError => e
        puts opts
        puts
        puts e.message
        exit(1)
      end

      if argv.empty?
        puts opts
        puts
        puts "Must specify a script to run"
        exit(1)
      end

      # install interruption handler
      trap('INT') { Debugger.interrupt_last }

      # set options
      Debugger.keep_frame_binding = options.frame_bind
      Debugger.tracing = options.tracing

      Debugger.start_server(options.host, options.port)
      Debugger.start do
        yield
      end

    else

      yield

    end

  end

end
