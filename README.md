# LoopsEmail
Unofficial loops email sdk. Official docs: https://loops.so/docs/start-here

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add loops_email

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install loops_email

## Usage

Create initializer `config/initializers/loops_email.rb`:
```ruby
LoopsEmail.configure do |config|
  config.api_key = "xxxxx" # if you're using rails, it's better to use built-in Credential
  # config.stub = Rails.env.development? && ENV["LOOPS_EMAIL_ENABLE"]&.empty?
  # config.log_file_path = "log/loops_email.log"
end
```

### Send transaction email
```ruby
result = LoopsEmail::Sdk::TransactionalEmail.new(
  receiver: "your_receiver_email",
  transaction_id: "your_transaction_id",
  variables: {
    your_variable_name: "your_variable_value"
  }
).call

if result.success?
  # handle success
else
  puts result.error
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/loops_email.
