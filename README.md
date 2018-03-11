# Churnalizer

Churnalizer helps you analyze the churn vs complexity of your Ruby application.

What is churn vs complexity? Sandi Metz explains it nicely in her blog post
[Breaking up the
Behemot](https://www.sandimetz.com/blog/2017/9/13/breaking-up-the-behemoth).

Churn is how many times a file has been changed, so basically you want files
which change a lot to be simple, and files which are never touched are fine with
being complex.

Of course, ideally you'll have no complex files but this allows you to identify
what to refactor first, and warn you when things are getting out of hand.

## Installation

```ruby
gem 'churnalizer'
```

## Usage

    $ churnalizer my-app

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/churnalizer.
