require 'forwardable'

module Ripgrep
  class Client
    extend Forwardable

    def_delegators Core, :exec, :version, :help
  end
end
