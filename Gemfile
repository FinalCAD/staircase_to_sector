source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in staircase_to_sector.gemspec
gemspec

gem 'file_model', git: 'https://github.com/FinalCAD/file_model'

group :test do
  gem 'mutant-rspec', git: 'https://github.com/mbj/mutant.git'
  gem 'coveralls', require: false
  gem 'pry-byebug'
end
