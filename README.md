# Yamls

[![Gem Version](https://badge.fury.io/rb/yamls.svg)](https://badge.fury.io/rb/yamls)
[![CircleCI](https://circleci.com/gh/TsuMakoto/yamls/tree/main.svg?style=svg)](https://circleci.com/gh/TsuMakoto/yamls/tree/main)

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/yamls`. To experiment with that code, run `bin/console` for an interactive prompt.

A gem that simplifies strong parameters that lengthen the code in Rails.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yamls'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install yamls

## Usage

In ActionController:

Before:

```ruby
def person_params
  params
    .require(:person)
    .permit(
      :name,
      :email,
      :first_name,
      :last_name,
      :age,
      :role,
      # ....other
    )
end
```

Use gem:

```ruby
def person_params
  Yamls::Parameters.new(
    params,
    model: :person,
    action: :post
  ).permit
end
```

In Yaml file (default: app/parameters/column.yml):

```yml
person:
  post:
    - name
    - email
    - first_name
    - last_name
    - age
    - role
    # ... other
```

### Include support function

If action_name and controller_name(with singularize) are the same as yaml configuration, it can be described below.

```ruby
class BooksController < ApplicationController
  include Yamls::Support::Parameters

  def action_name_1
    params = yamls
  end

  def action_name_2
    params = yamls
  end

  def action_name_3
    params = yamls
  end
end
```

In Yaml file:

```yml
book:
  action_name_1:
    # set columns
  action_name_2:
    # set columns
  action_name_3:
    # set columns
```

Define method:

```ruby
class BooksController < ApplicationController
  include Yamls::Support::Parameters

  def action_name_1
    params = book_action_name_1_params # {controller_name.singularize}_{action_name}_params
  end

  def action_name_2
    params = book_action_name_2_params
  end

  def action_name_3
    params = book_action_name_3_params
  end
end

```

### Initialize configuration

1) If you want to specify a file:

```ruby
Yamls::Parameters.new(
  params,
  file_path: "path/to/column.yml"
)

```

2) Nested parameters:

In Yaml file:

```yml
main:
  nested1:
    nested2:
      nested3:
        - name
        - label
        - values:
            - a_site
            - b_site
            - c_site
```

Request params:

```json

{
    "books": {
        "name": "Books name",
        "label": "Books label",
        "values": {
            "a_site": 1000,
            "b_site": 2000,
            "c_site": 3000
        }
    }
}

```

In controller:

```ruby
Yamls::Parameters.new(
  params,
  required: :book,
  nested:   %i[main nested1 nested2 nested3]
)

```

3) Model specification only:

If the parameters of create and update are the same, you want to combine them into one.

```yml
book:
  - name
  - label
  - value

```

```ruby
Yamls::Parameters.new(
  params,
  model: :book,
)

```

4) If you don't need a require method chain:

```yml
book:
  - name
  - label
  - value

```

Request params:

```json

{
    "name": "Books name",
    "label": "Books label",
    "value":  1000
}

```

In controller:

```ruby
Yamls::Parameters.new(
  params,
  nested: %i[book]  # if you have a yaml with multi level
)

```

or

```ruby
Yamls::Parameters.new(
  params,
  model: :book,
  required: nil
)

```

```ruby
Yamls::Parameters.new(
  params,
  action: :book,
  required: nil
)

```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/yamls. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/yamls/blob/master/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the Yamls project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/yamls/blob/master/CODE_OF_CONDUCT.md).
