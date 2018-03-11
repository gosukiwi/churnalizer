require "churnalizer/analyzer"

module Churnalizer
  class CLI
    attr_accessor :path

    def initialize
      @path = path
      analyze
    end

    def analyze
      return help if path.nil?
      puts churnalizer.run
    end

    def churnalizer
      @churnalizer ||= Churnalizer::Analyzer.new(path)
    end

    def help
      puts """This is Churnalizer, a churn vs complexity analyzer for your Ruby
application.

Usage:
churnalizer my-app/
      """
    end

    def path
      ARGV[0]
    end
  end
end
