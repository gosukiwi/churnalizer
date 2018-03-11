require "churnalizer/version"
require "json"
require "file_scanners/ruby"
require "churn_analyzers/git"
require "complexity_analyzers/ruby"

module Churnalizer
  class Analyzer
    attr_reader :path
    def initialize(path)
      @path = path
    end

    def run
      result = files.map do |file|
        [file.gsub(path, "."), { churn: churn_for(file), complexity: complexity_for(file) }]
      end.to_h

      build_graph(result)
    end

    private

    def files
      file_scanner.scan
    end

    def file_scanner
      @file_scanner ||= FileScanners::Ruby.new(path)
    end

    def churn_analyzer
      @churn_analyzer ||= ChurnAnalyzers::Git.new
    end

    def churn_for(file)
      churn_analyzer.analyze(file)
    end

    def complexity_analyzer
      @complexity_analyzer ||= ComplexityAnalyzers::Ruby.new
    end

    def complexity_for(file)
      complexity_analyzer.analyze(file)
    end

    def build_graph(result)
      root_path = File.expand_path "#{File.dirname(__FILE__)}/../"
      chart_view = File.read("#{root_path}/lib/views/chart.html.erb")
      
      template = chart_view.gsub("{{graph_data}}", result.to_json)

      # Write in current working directory
      File.write("chart.html", template)
      `open chart.html`
    end

  end
end
