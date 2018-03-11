require "churnalizer/analyzer"

module Churnalizer
  class CLI
    def initialize
      puts parse_action
    end

    private

    def analyze(path)
      churnalizer = Churnalizer::Analyzer.new(path)
      churnalizer.run
    end

    def parse_action
      case action
      when "help"
        help
      when "version"
        version
      else
        analyze action
      end
    end

    def help
      """This is Churnalizer, a churn vs complexity analyzer for your Ruby
application.

Usage:
churnalizer my-app/

churnalizer help
  displays this dialog

churnalizer version
  displays current version
      """
    end

    def version
      Churnalizer::VERSION
    end

    def action
      ARGV[0]
    end
  end
end
