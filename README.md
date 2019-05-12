# ripgrep-ruby

A Ruby wrapper around [ripgrep](https://github.com/BurntSushi/ripgrep)!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ripgrep'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ripgrep

## Usage

```ruby
require 'ripgrep'

rg = Ripgrep::Client.new

### return the version like `rg --version`
puts rg.version
# =>
#    ripgrep 11.0.1
#    -SIMD -AVX (compiled)
#    +SIMD +AVX (runtime)

### Search like `rg require lib`
result = rg.exec 'require', path: 'lib'
puts result
# =>
#    lib/ripgrep.rb:require 'ripgrep/version'
#    lib/ripgrep.rb:require 'ripgrep/core'
#    lib/ripgrep.rb:require 'ripgrep/client'
#    lib/ripgrep.rb:require 'ripgrep/result'
#    lib/ripgrep/client.rb:require 'forwardable'
#    lib/ripgrep/core.rb:require 'open3'

puts result.matches
# =>
#    {:file=>"lib/ripgrep.rb", :body=>"require 'ripgrep/version'"}
#    {:file=>"lib/ripgrep.rb", :body=>"require 'ripgrep/core'"}
#    {:file=>"lib/ripgrep.rb", :body=>"require 'ripgrep/client'"}
#    {:file=>"lib/ripgrep.rb", :body=>"require 'ripgrep/result'"}
#    {:file=>"lib/ripgrep/client.rb", :body=>"require 'forwardable'"}
#    {:file=>"lib/ripgrep/core.rb", :body=>"require 'open3'"}

### Search like `rg --ignore-case ruby ripgrep.gemspec`
result = rg.exec 'ruby', path: 'ripgrep.gemspec', options: { ignore_case: true }
puts result
# =>
#     spec.summary       = "A Ruby wrapper around ripgrep!"
#     spec.description   = "A Ruby wrapper around ripgrep!"
#     spec.homepage      = "https://github.com/shuuuuun/ripgrep-ruby"
#     # The `git ls-files -z` loads the files in the RubyGem that have been added into git.

### You can use `rg` method in run block.
rg.run do
  result = rg '--ignore-case', 'ruby'
  puts result
end

Ripgrep.run do
  result = rg '--ignore-case', 'ruby'
  puts result
end
```

## Links

* Original: https://github.com/BurntSushi/ripgrep
* GitHub: https://github.com/shuuuuun/ripgrep-ruby
* RubyGems: https://rubygems.org/gems/ripgrep

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shuuuuun/ripgrep-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
