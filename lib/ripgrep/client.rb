require 'forwardable'

module Ripgrep
  class Client
    extend Forwardable

    def_delegators Core, :version, :help, :files

    def initialize(verbose: false)
      @verbose = verbose
    end

    def exec(*args, opts)
      unless opts.is_a? Hash
        args << opts
        opts = {}
      end
      verbose = opts[:verbose].nil? ? @verbose : !!opts[:verbose]
      cli_options = opts[:options]&.flat_map do |key, val|
        next [] unless val
        key = key.to_s.tr('_', '-')

        if val.is_a? Array
          # For arrays, create multiple --key=val options
          val.map { |v| "--#{key}=#{v}" }
        elsif val.is_a? TrueClass
          # For true, create --key option without value
          ["--#{key}"]
        elsif val.is_a? String
          # For strings, skip empty strings, otherwise use --key=val format
          val.empty? ? [] : ["--#{key}=#{val}"]
        else
          # For other values, convert to string
          ["--#{key}=#{val}"]
        end
      end&.compact || []
      puts "cli_options: #{cli_options}" if verbose
      cli_arguments = cli_options + args
      cli_arguments << (opts[:path] || '.')
      puts "cli_arguments: #{cli_arguments}" if verbose
      Core.exec(*cli_arguments, verbose: verbose)
    end

    def run(&block)
      instance_eval(&block)
    end

    private

    def rg(*args)
      return self if args.empty?
      exec(*args, verbose: @verbose)
    end
  end
end
