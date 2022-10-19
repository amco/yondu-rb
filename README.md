# Yondu - Settings object for extending configuration

This gem aims to provide a simple wrapper over configuration objects in
ruby applications.

## Installation

Add `Yondu` to your application's Gemfile:

```ruby
gem "yondu"
```

## Configuration

Lets assume you have a `settings.yml` file in a `config` folder with the
following information:

```yml
development:
  app:
    host: "myapp.com"
    port: 443
```

For rails applications, add the following in your `config/application.rb`:

```ruby
module MyApp
  class Application < Rails::Application
    ...

    config.settings = Yondu::Settings.new(config_for(:settings))
  end
end
```

## Usage

Use your settings where you need. Example:

```ruby
Rails.configuration.settings.get(:app)
# => { host: "myapp.com", port: 443 }

Rails.configuration.settings.get(:app, :port)
# => 443

Rails.configuration.settings.get(:app, :use_ssl)
# => Missing setting: app->use_ssl (Yondu::MissingSetting)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then,
run `rake spec` to run the tests. You can also run `bin/console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and
then run `bundle exec rake release`, which will create a git tag for the
version, push git commits and the created tag, and push the `.gem` file
to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/amco/yondu-rb.
This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the
[code of conduct](https://github.com/amco/yondu-rb/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Yondu project's codebases, issue trackers,
chat rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/amco/yondu-rb/blob/master/CODE_OF_CONDUCT.md).
