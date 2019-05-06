require 'open3'

module Ripgrep
  class Core
    def self.exec(*args, opts)
      unless opts.is_a? Hash
        args << opts
        opts = {}
      end
      opts = { path: '.' }.merge(opts)
      # puts "args: #{args}, opts: #{opts}"
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
