# If you have OpenSSL installed, we recommend updating
# the following line to use "https"
source 'http://rubygems.org'

gem "middleman", "~>4.2"

# bloggity-blog
gem 'middleman-blog'
gem 'redcarpet'
gem 'nokogiri'
gem 'builder'

gem 'middleman-search', git: 'https://github.com/Notificare/middleman-search.git'

# allows for imprecise dates in quotes, events
gem 'edtf'
gem 'edtf-humanize'

# for Travis deployment
gem 's3_website'

# also used by Travis CI
group :development do
  gem 'rake', '~> 10.4'
  gem 'rspec', '~> 3.4'
  gem 'capybara', '~> 2.5'
end
