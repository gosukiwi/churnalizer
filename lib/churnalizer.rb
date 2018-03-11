require "churnalizer/version"
require "flog"
require "json"

module Churnalizer
  class Analyze
    class << self
      def run(path=ARGV[0])
        # This is what we have to do:
        # 1. Find all ruby classes
        # 2. For each class, get the complexity and the churn (how many times) it was changed
        # 3. Make a graph
        
        result = ruby_files_in(path).map do |file|
          [file.gsub(path, "."), { churn: churn_for(file), complexity: complexity_for(file) }]
        end.to_h

        build_graph(result)
      end

      private

      def build_graph(result)
        root_path = File.expand_path "#{File.dirname(__FILE__)}/../"
        chart_view = File.read("#{root_path}/lib/views/chart.html.erb")
        
        template = chart_view.gsub("{{graph_data}}", result.to_json)

        # Write in current working directory
        File.write("chart.html", template)
        `open chart.html`
      end

      def ruby_files_in(base_path)
        Dir.glob("#{base_path}/**/*.rb")
      end

      # This command uses git to find out how many times this file was changed.
      # Needless to say, it must be under version control.
      def churn_for(file)
        `cd $(dirname #{file}) && git log --oneline -- #{file} | wc -l`.gsub(/[\n ]+/, "").to_i
      end

      def complexity_for(file)
        flog.reset
        flog.flog(file)
        flog.total_score
      end

      def flog
        @flog ||= Flog.new
      end
    end
  end
end
