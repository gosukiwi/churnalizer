RSpec.describe FileScanners::Ruby do
  it "uses glob to find files" do
    scanner = FileScanners::Ruby.new("foo")
    allow(Dir).to receive(:glob).and_return([])

    scanner.scan

    expect(Dir).to have_received(:glob).with("foo/**/*.rb")
  end

  it "uses an ignorer" do
    scanner = FileScanners::Ruby.new("foo")
    ignorer = spy
    allow(scanner).to receive(:files).and_return(["foo.rb", "bar.rb"])
    allow(scanner).to receive(:ignorer).and_return(ignorer)
    allow(ignorer).to receive(:ignore?).and_return(true)

    scanner.scan

    expect(ignorer).to have_received(:ignore?).with("foo.rb")
    expect(ignorer).to have_received(:ignore?).with("bar.rb")
  end
end
