require "churnalizer/version"

module Churnalizer
  class Analyze
    class << self
      def run(path=ARGV[0])
        # This is what we have to do:
        # 1. Find all ruby classes
        # 2. For each class, get the complexity and the churn (how many times) it was changed
        # 3. Make a graph
        
        ruby_files_in path
      end

      private

      def ruby_files_in(base_path)
        Dir.glob("#{base_path}/**/*.rb")
      end
    end
  end
end
