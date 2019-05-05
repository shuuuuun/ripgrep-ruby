require 'ripgrep/version'
require 'ripgrep/core'

module Ripgrep
  class Error < StandardError; end
  class CommandExecutionError < Error; end
  class NoMatchError < Error; end
end
