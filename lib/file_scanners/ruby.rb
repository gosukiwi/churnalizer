require "file_scanners/ignorer"

module FileScanners
  # FileScanners are in charge of finding files to be analyzed. This one in
  # particular finds Ruby files.
  #
  class Ruby
    attr_reader :path
    def initialize(path)
      @path = path
    end

    def scan
      files.reject do |file|
        ignore? file
      end
    end

    private

    def files
      Dir.glob("#{path}/**/*.rb")
    end

    def ignorer
      @ignorer ||= Ignorer.new(path)
    end

    def ignore?(file)
      ignorer.ignore? file
    end
  end
end
