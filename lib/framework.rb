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
