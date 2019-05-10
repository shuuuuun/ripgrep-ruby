require 'ripgrep/version'
require 'ripgrep/core'
require 'ripgrep/client'
require 'ripgrep/result'

module Ripgrep
  class Error < StandardError; end
  class CommandExecutionError < Error; end
  class NoMatchError < Error; end
  class ResultError < Error; end

  class << self
    def run(&block)
      Client.new.run(&block)
    end
  end
end
