require "json"

module GraphBuilders
  # Generate an HTML chart using Google Charts
  #
  class GoogleCharts
    def build(graph_data, save_to:)
      write_chart graph_data, to_file: save_to
      open_with_default_browser save_to
      File.expand_path save_to
    end

    private

    def open_with_default_browser(file)
      `open #{file}` if `which open` == "/usr/bin/open\n"
    end

    def write_chart(graph_data, to_file:)
      contents = compile_template graph_data
      File.write(to_file, contents)
    end

    def compile_template(graph_data)
      template.gsub("{{graph_data}}", graph_data.to_json)
    end

    def template
      File.read view_path("google_chart.html")
    end

    def view_path(name)
      "#{__dir__}/views/#{name}"
    end
  end
end
