# Has Unique Attribute

Applies validation errors to ActiveRecord model attributes when database uniqueness constraints fail.

**NOTE:** At the moment, only PostgreSQL is supported.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'has_unique_attribute'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install has_unique_attribute

Then, make it available to your models:

```ruby
class ApplicationRecord < ActiveRecord::Base
  extend HasUniqueAttribute

  # ...
end
```

## Usage

Use the `has_unique_attribute` helper to add a handler to your model:

```ruby
class User < ApplicationRecord
  has_unique_attribute :email
end
```

This will match errors on an index name `index_users_on_email` and add validation errors to the `email` attribute.

### Specifying an Index Name

To customize the name of the index matched, use the `index` option:

```ruby
class User < ApplicationRecord
  has_unique_attribute :email, index: 'custom_index_name'
end
```

### Customizing the Error Message

To customize the error message applied, use the `message` option:

```ruby
class Project < ApplicationRecord
  has_unique_attribute :name, message: 'already exists'
end
```

It's also possible to specify an I18n key for a translation:

```ruby
class Project < ApplicationRecord
  has_unique_attribute :name, message: :duplicate
end
```

By default, the `:taken` error translation is applied to attributes.
This mimics the behaviour of the `uniqueness` validator.

### Handling Composite Indexes

Composite (multi-column) indexes will need the index name to be specified explicitly:

```ruby
class Membership < Application
  belongs_to :user
  belongs_to :club

  has_unique_index :user, index: 'index_memberships_on_club_id_and_user_id', message: 'is already a member'
end
```

The error is only applied to the specified attribute.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Mihail-K/has_unique_attribute.
