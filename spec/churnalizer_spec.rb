RSpec.describe Churnalizer do
  it "has a version number" do
    expect(Churnalizer::VERSION).not_to be nil
  end

  it "does something useful" do
    analyzer = Churnalizer::Analyzer.new "/Users/gosukiwi/Workspace/ficlovers"
    expect(analyzer.run).to eq(true)
  end
end
