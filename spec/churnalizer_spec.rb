RSpec.describe Churnalizer do
  it "has a version number" do
    expect(Churnalizer::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(Churnalizer::Analyze.run("/Users/gosukiwi/Workspace/churn-vs-complexity/churnalizer")).to eq(true)
  end
end
