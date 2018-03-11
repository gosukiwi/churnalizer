# Churnalizer

Churnalizer helps you analyze the churn vs complexity of your Ruby application.

![Graph Screenshot](screenshot.png?raw=true)

What is churn vs complexity? Sandi Metz explains it nicely in her blog post
[Breaking up the
Behemot](https://www.sandimetz.com/blog/2017/9/13/breaking-up-the-behemoth).

Basically, it shows you which files need to be refactored first -- top-right
corner of the graph. Churn is how many times a file has been changed, so you
want files which change a lot to be simple. Files which are never touched are
fine with being complex for a while.

## Installation

```ruby
gem 'churnalizer'
```

## Usage

    $ churnalizer my-app-directory/

This was only tested on MacOS. It uses the `open` command to make things easier,
so when the gem is done analyzing your app, it will open the generated chart
with your default browser. 

That functionality would not work on Linux so the chart would need to be opened
manually.

Don't think it works on Windows at all, given the churn counter uses the
following command: `cd $(dirname #{file}) && git log --oneline -- #{file} | wc -l`

### Ignoring Files

By default, Churnalizer will ignore specs and Rails files like `schema.rb` and
`routes.rb`.

For custom ignore rules, in the base directory you are analyzing, create a file
named `.churnignore`, in that file, add a regular expression per-line to run
against file paths. If a regex returns true, it will be ignored.

For example, this is the default `.churnignore` file:

    /test/
    /spec/
    /db/
    /config/
    /bin/
    /vendor/
    /public/

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

### Playing with the CLI

To locally run the CLI use `ruby -Ilib exe/churnalizer`

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/gosukiwi/churnalizer.
