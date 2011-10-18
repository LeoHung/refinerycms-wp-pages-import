source "http://rubygems.org"

group :development, :test do
  gem "rspec-rails", ">= 2.6.0"
  gem "database_cleaner"
  gem 'guard-rspec'
  gem 'ffi'
  gem 'guard-bundler'
  gem 'libnotify' if  RUBY_PLATFORM =~ /linux/i
  gem 'fakeweb'
end

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

gem 'refinerycms'
gem 'refinerycms-blog',            :git => "git://github.com/wikyd/refinerycms-blog.git", :branch => "custom_teasers"
gem 'refinerycms-page-images', '~> 1.0', :git => "git://github.com/resolve/refinerycms-page-images.git"
gem 'refinerycms-settings-initializer'
gem 'refinerycms-resource_guides', :git => 'git://github.com/raphaelcm/resource_guides.git'
gem 'refinerycms-resource_documents', :git => 'git://github.com/raphaelcm/Refinery-CMS-Resource-Documents.git'