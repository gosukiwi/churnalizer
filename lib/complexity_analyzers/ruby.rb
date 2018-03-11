require "flog"

module ComplexityAnalyzers
  # This class uses Flog <https://github.com/seattlerb/flog> to check the
  # complexity of a Ruby file.
  #
  class Ruby
    def analyze(file)
      flog.reset
      flog.flog(file)
      flog.total_score
    end

    def flog
      @flog ||= Flog.new
    end
  end
end
