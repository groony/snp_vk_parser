# SnpVkParser

[![Gem Version](https://badge.fury.io/rb/snp_vk_parser.svg)](https://badge.fury.io/rb/snp_vk_parser)

![Salt & Pepper](https://avatars3.githubusercontent.com/u/9194399?v=3&amp;s=100)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'snp_vk_parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install snp_vk_parser

## Usage


### Group user activity

```ruby
vk_group = SnpVkParser::Group.new(id: group_id, user_id: user_id, post_ids: post_ids, token: token)
```

Check membership

```ruby
vk_group.member?
```

List ids members

```ruby
vk_group.members
```

#### Counters:

- In posts:

```ruby
vk_group.posts_user_comment_count
```

```ruby
vk_group.posts_user_like_count
```

```ruby
vk_group.posts_user_repost_count
```

- In albums:

```ruby
vk_group.albums_user_photo_count
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/groony/snp_vk_parser. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

