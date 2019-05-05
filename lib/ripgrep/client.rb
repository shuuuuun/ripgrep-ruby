require 'forwardable'

module Ripgrep
  class Client
    extend Forwardable

    def_delegators Core, :exec, :version, :help

    def run(&block)
      instance_eval(&block)
    end

    private

    def rg(*args)
      return self if args.empty?
      Core.exec(*args)
    end
  end
end
