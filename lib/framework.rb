# frozen_string_literal: true

require "zeitwerk"

module Framework
  @root = nil

  def self.root
    @root
  end

  def self.root=(path)
    @root = path
  end

  def self.setup(root_path = nil)
    self.root = root_path || Dir.pwd
    setup_loader
    self
  end

  def self.setup_loader
    loader = Zeitwerk::Loader.new
    loader.push_dir(File.join(root, "lib"))
    loader.ignore(File.join(root, "lib", "framework.rb"))
    loader.setup
    loader.eager_load # Using eager loading as specified in the requirements
  end
  private_class_method :setup_loader
end
