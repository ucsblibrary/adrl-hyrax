# frozen_string_literal: true

source "https://rubygems.org"

gem "rails", "~> 5.1.3"

gem "bcrypt"
gem "blacklight_range_limit"
gem "coffee-rails"
gem "ezid-client"
gem "hydra-role-management"
gem "hyrax", path: "/Users/alex/clones/hyrax"
gem "jbuilder"
gem "jquery-rails"
gem "linked_vocabs",
    git: "https://github.com/projecthydra-labs/linked_vocabs.git",
    ref: "67d80da0de07bf428c7f1a70ac2647b96edc274b"
gem "marc"
gem "metadata_ci",
    git: "https://github.com/ucsblibrary/metadata-ci.git",
    ref: "be592cdfc3d5a464d60f2cf3496409026e505d38"
gem "net-ldap"
gem "puma"
gem "rdf-vocab", path: "/Users/alex/clones/rdf-vocab"
gem "redis"
gem "riiif"
gem "rsolr"
gem "sass-rails"
gem "settingslogic"
gem "traject"
gem "trollop"
gem "uglifier"

group :production do
  gem "pg", "~> 0.18"
end

group :development do
  gem "capistrano-rails"
  gem "method_source"
  gem "pry"
  gem "rubocop"
  gem "rubocop-rspec"
  gem "spring"
  gem "web-console"
end

group :development, :test do
  gem "byebug"
  gem "capybara"
  gem "fcrepo_wrapper"
  gem "rspec-rails"
  gem "selenium-webdriver"
  gem "solr_wrapper"
  gem "sqlite3"
end
