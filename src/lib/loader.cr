module CRCRCR
  class Loader
    def self.load_files(path : Path)
      files = [] of String

      Dir.new(path.to_s).each_child do |x|
        if !x.starts_with? "_"
          currentPath = path.join(x)
          if File.directory? currentPath.to_s
            files.concat(self.load_files(currentPath))
          else
            files.push(currentPath.to_s)
          end
        end
      end

      files
    end

    def self.run(path : Path)
      files = self.load_files path

      hash = Hash(String, String).new
      files.each do |f|
        hash[f] = File.read f
      end

      hash
    end
  end
end
