# Ruby Framework

A lightweight, flexible Ruby framework designed to provide a structured setup for Ruby projects. Unlike traditional gems, this framework lives inside your project's directory, giving you full control over updates and modifications.

## Features

- **Autoloading**: Uses Zeitwerk in eager-load mode for efficient file management
- **Testing**: Preconfigured with RSpec
- **Code Style**: Enforces standards using Rubocop
- **Initializers**: Dedicated directory for setup code
- **CLI with Generators**: Similar to Rails generators
- **Environment Support**: Configuration via DotEnv
- **Minimal Dependencies**: Only includes essential gems
- **Pure Ruby Configuration**: No YAML or other config files, just Ruby
- **Docker Support**: Included Docker and Docker Compose files

## Getting Started

### Installation

Create a new project using the generator:

```bash
bin/dalek-new PROJECT_NAME [options]
```

Options:
- `-o, --output-dir DIR`: Output directory (default: current directory)
- `-s, --source-dir DIR`: Source directory (for local development)

### Usage

Create a main Ruby file that loads your framework and application:

```ruby
#!/usr/bin/env ruby
# frozen_string_literal: true

# Get the absolute path to the project root
project_root = File.expand_path("..", __dir__)

# Add the lib directory to the load path
$LOAD_PATH.unshift(File.join(project_root, "lib"))

# Require the framework
require "framework"
framework = Framework.new(root: project_root)

# Run your application
MyProject::Hello.world
```

## How It Works

### Framework Implementation

The framework provides class-based initialization with Zeitwerk autoloading:

```ruby
# frozen_string_literal: true

require "zeitwerk"

class Framework
  VERSION = "0.1.0"

  attr_reader :root

  def initialize(root:)
    @root = root
    @loader = setup_loader
  end

  private

  def setup_loader
    loader = Zeitwerk::Loader.new
    loader.push_dir(File.join(root, "lib"))
    loader.ignore(File.join(root, "lib", "framework.rb"))
    loader.setup
    loader.eager_load # Using eager loading as specified in the requirements
    loader
  end
end
```

### Autoloading

The framework uses Zeitwerk for autoloading your classes and modules. When you create a new `Framework` instance, it configures Zeitwerk to eagerly load all Ruby files in your project's `lib` directory (except for `framework.rb` itself).

Classes and modules are expected to follow Ruby's naming conventions, which Zeitwerk enforces. For example:
- A file at `lib/my_module/my_class.rb` should define `MyModule::MyClass`
- A file at `lib/service.rb` should define `Service`

### Project Structure

The framework follows a structured organization:

```
my_project/
├── bin
│   └── dalek-new
├── Gemfile
├── lib
└── README.md
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
