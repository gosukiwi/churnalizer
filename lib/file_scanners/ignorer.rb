module FileScanners
  # Takes a list of files and ignores them appropriately
  #
  class Ignorer
    DEFAULT_IGNORES = %w[/test/ /spec/ /db/ /config/ /bin/ /vendor/ /public/].freeze

    attr_reader :path
    def initialize(path)
      @path = path
    end

    def ignore?(file)
      ignore_rules.each do |rule|
        return true if rule === file
      end
      false
    end

    private

    def ignore_rules
      @ignore_rules ||= churnignore.map { |regex| Regexp.new(regex) }
    end

    def churnignore
      if churnignore_contents.empty?
        DEFAULT_IGNORES
      else
        churnignore_as_array
      end
    end

    def churnignore_as_array
      churnignore_contents.split("\n").compact
    end

    def churnignore_contents
      @churnignore_contents ||= File.read(churnignore_path)
    rescue Errno::ENOENT
      ""
    end

    def churnignore_path
      "#{path}/.churnignore"
    end
  end
end
