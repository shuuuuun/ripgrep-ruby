require 'open3'

module Ripgrep
  class Core
    def self.exec(*args, opts)
      unless opts.is_a? Hash
        args << opts
        opts = {}
      end
      opts = { path: '.' }.merge(opts)
      cli_options = opts[:options]&.map do |key, val|
        next unless val
        val = '' if val.is_a? TrueClass
        val = val.join if val.is_a? Array
        key = key.to_s.tr('_', '-')
        "--#{key} #{val}".strip
      end&.compact
      args = cli_options + args if cli_options
      # TODO: make debug logger
      # puts "args: #{args}, opts: #{opts}"
      # TODO: verbose option
      stdout, stderr, status = Open3.capture3('rg', *args, opts[:path])
      unless status.exited?
        # puts "exit status: #{status.exitstatus}"
        raise Ripgrep::CommandExecutionError, stderr 
      end
      Result.new stdout, stderr, exit_status: status.exitstatus
    end

    def self.version
      self.exec('--version').to_s
    end

    def self.help
      self.exec('--help').to_s
    end
  end
end
