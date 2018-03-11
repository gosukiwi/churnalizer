module GraphBuilders
  # Generate an HTML chart using Google Charts
  #
  class GoogleCharts
    def build(graph_data)
      base_path = File.expand_path "#{File.dirname(__FILE__)}"
      chart_view = File.read("#{base_path}/views/chart.html.erb")
      template = chart_view.gsub("{{graph_data}}", graph_data.to_json)

      # Write in current working directory
      File.write("chart.html", template)
      `open chart.html`
    end
  end
end

