# StaircaseToSector

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/staircase_to_sector`. To experiment with that code, run `bin/console` for an interactive prompt.

[![Maintainability](https://api.codeclimate.com/v1/badges/b555e20a16d6c8776959/maintainability)](https://codeclimate.com/github/FinalCAD/staircase_to_sector/maintainability)

[![Dependency Status](https://gemnasium.com/FinalCAD/staircase_to_sector.svg)](https://gemnasium.com/FinalCAD/staircase_to_sector)

[![Build Status](https://travis-ci.org/FinalCAD/staircase_to_sector.svg?branch=master)](https://travis-ci.org/FinalCAD/staircase_to_sector) (Travis CI)

[![Coverage Status](https://coveralls.io/repos/FinalCAD/staircase_to_sector/badge.svg?branch=master&service=github)](https://coveralls.io/github/FinalCAD/staircase_to_sector?branch=master)

[![Inline docs](http://inch-ci.org/github/FinalCAD/staircase_to_sector.svg?branch=master)](http://inch-ci.org/github/FinalCAD/staircase_to_sector)

A lib to compose files into Staircases

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'staircase_to_sector'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install staircase_to_sector

## Usage

You need to add `file_model` gem https://rubygems.org/gems/file_model

```
require 'file_model'
```

Define your model based on `FileModel::Model::File` to override behavior

```
class StaircaseFileModel
  include FileModel::Model::File

  def skip?
    false # Need all files and directories
  end
end
```

Use the `FileModel::Import::Dir` of `file_model`

```
source_path = '../file_model/spec/fixtures/archive/input'
import = FileModel::Import::Dir.new(source_path: source_path, model: StaircaseFileModel)
```

Create the directory where you want your output files

```
export_path = Dir.mktmpdir
FileUtils.mkdir_p(export_path)
```

Get on instance of store for keep the instantiated models

```
store = FileModel::Store::Memory.instance
```

store your files

```
import.each { |model| store << model }
```

Process you files

```
processor_klass = StaircaseToSector::Processors::StaircaseComposer
options = {}
export = FileModel::Export::Dir.new(export_path: export_path, processor: processor_klass, options: options, store: store)
export.each(options) do |model|
  puts("File: #{model.source_path} Successfully treated")
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/staircase_to_sector. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the StaircaseToSector project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/staircase_to_sector/blob/master/CODE_OF_CONDUCT.md).
