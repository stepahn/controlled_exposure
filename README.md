# ControlledExposure

explicit expose rails controller `@instance` variables as helpers in views. optional prevent all access to `@instance` variables in views.


## Changes

### 2.0
- add `attr_expose`
- add `def_expose`
- deprecate `expose`
- this is now based on `ActiveSupport::Concern`


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'controlled_exposure'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install controlled_exposure

## Usage

in your controller `app/controllers/hello_controller.rb`

```ruby
class HelloController < ApplicationController
  enforce_expose!
  attr_expose :foo, :bar

  def show
    @foo = 'Hello'
    self.bar = 'World!'
  end
end
```

and `app/views/hello/show.html.erb`

```ruby
<%= foo %><%= bar %>
```

instead of

```ruby
<%= @foo %><%= @bar %>
```


There is also a `def_expose`

```ruby
class HelloController < ApplicationController
  def_expose :foobar do
    "Hello World!"
  end
end
```

which is a shorthand for

```
class HelloController < ApplicationController
  def foobar
    "Hello World!"
  end

  helper_method :foobar
  protected_method :foobar
end

```

### Enable for All Controllers

```ruby
class ApplicationController < ActionController::Base
  enforce_expose!
  attr_expose :foo
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/stepahn/controlled_exposure.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
