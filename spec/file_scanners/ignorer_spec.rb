RSpec.describe FileScanners::Ignorer do
  it "works with default ignores" do
    ignorer = FileScanners::Ignorer.new("dummy_path")

    expect(ignorer.ignore?("/spec/foo.rb")).to   eq true
    expect(ignorer.ignore?("/test/foo.rb")).to   eq true
    expect(ignorer.ignore?("/db/foo.rb")).to     eq true
    expect(ignorer.ignore?("/config/foo.rb")).to eq true
    expect(ignorer.ignore?("/bin/foo.rb")).to    eq true
    expect(ignorer.ignore?("/vendor/foo.rb")).to eq true
    expect(ignorer.ignore?("/public/foo.rb")).to eq true
    expect(ignorer.ignore?("/bar/foo.rb")).to    eq false
  end

  it "works with custom churnignore" do
    ignorer = FileScanners::Ignorer.new("dummy_path")
    allow(ignorer).to receive(:churnignore_contents).and_return("/foo/")

    expect(ignorer.ignore?("/foo/bar.rb")).to eq true
    expect(ignorer.ignore?("/bar/bar.rb")).to eq false
  end

  it "reads churnignore from file" do
    Dir.mkdir "demo"
    File.write "demo/.churnignore", "/foo/\n/bar/\n"
    ignorer = FileScanners::Ignorer.new("demo")

    expect(ignorer.ignore?("/foo/bar.rb")).to eq true
    expect(ignorer.ignore?("/bar/bar.rb")).to eq true
    expect(ignorer.ignore?("baz.rb")).to      eq false

    File.delete "demo/.churnignore"
    Dir.rmdir "demo"
  end
end
