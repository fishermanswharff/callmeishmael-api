module FileRenamer

  class Namer

    def self.rename
      filepath = '/Users/jason/Documents/thinq/Projects/Call-Me-Ishmael/Assets/Audio'

      Dir.foreach(filepath){ |file|
        next if file.in?(%w(. .. .DS_Store))
        File.rename(filepath + '/' + file, filepath + '/' + file.gsub(/\s/,'-'))
      }
    end
  end
end