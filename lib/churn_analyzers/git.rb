module ChurnAnalyzers
  # This class uses Git to analyze the churn (how many times it was changed) of
  # a file.
  #
  class Git
    def analyze(file)
      as_integer run_command(file)
    end

    private

    # Trim string and cast to integer
    def as_integer(string)
      string.gsub(/[\n ]+/, "").to_i
    end

    # NOTE: This only works on *NIX systems
    def run_command(file)
      `cd $(dirname #{file}) && git log --oneline -- #{file} | wc -l`
    end
  end
end
