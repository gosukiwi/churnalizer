require "file_scanners/ruby"
require "churn_analyzers/git"
require "complexity_analyzers/ruby"
require "graph_builders/google_charts"
require "churnalizer/version"

module Churnalizer
  class Analyzer
    attr_reader :path
    def initialize(path)
      @path = File.expand_path path
    end

    def run
      build_graph analyzed_files
    end

    private

    def analyzed_files
      files.map do |file|
        [display_name_for(file), analyze(file)]
      end.to_h
    end

    def display_name_for(file)
      file.gsub(path, ".")
    end

    def analyze(file)
      { churn: churn_for(file), complexity: complexity_for(file) }
    end

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

    def graph_builder
      @graph_builder ||= GraphBuilders::GoogleCharts.new
    end

    def build_graph(graph_data)
      graph_builder.build(graph_data, save_to: "chart.html")
    end
  end
end
