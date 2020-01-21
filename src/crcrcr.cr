require "option_parser"
require "./lib/loader"
require "./lib/ui"

module CRCRCR
  VERSION         = {{ `cat #{__DIR__}/../VERSION`.stringify.chomp }}
  DEFAULT_COMMAND = "run"

  def self.execute(width : String | Nil)
    puts "CRCRCR v#{VERSION}"

    files = Loader.run Path[Dir.current]
    puts "Found #{files.size} slides, launching UI."

    Ui.run(files, width)
  end

  def self.run
    width : String | Nil = nil

    OptionParser.parse do |parser|
      parser.banner = "Usage: crcrcr [arguments]"
      parser.on("-w WIDTH", "--width=WIDTH", "Fix the presentation width: crcrcr -w 400") { |w| width = w }
      parser.on("-h", "--help", "Show this help") do
        puts parser
        exit(0)
      end

      parser.invalid_option do |flag|
        STDERR.puts "ERROR: #{flag} is not a valid option."
        STDERR.puts parser
        exit(1)
      end

      parser.unknown_args do |args, options|
        case args[0]? || DEFAULT_COMMAND
        else
          self.execute width
        end
      end
    end
  end
end

CRCRCR.run
