require 'ripgrep/version'
require 'ripgrep/core'
require 'ripgrep/client'
require 'ripgrep/result'

module Ripgrep
  class Error < StandardError; end
  class CommandExecutionError < Error; end
  class NoMatchError < Error; end
  class ResultError < Error; end
end
