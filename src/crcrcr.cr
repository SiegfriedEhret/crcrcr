require "./lib/loader"
require "./lib/ui"

module CRCRCR
  VERSION = {{ `cat #{__DIR__}/../VERSION`.stringify.chomp }}

  def self.run
    puts "CRCRCR v#{VERSION}"

    files = Loader.run Path[Dir.current]
    puts "Found #{files.size} slides, launching UI."

    Ui.run files
  end
end

CRCRCR.run
