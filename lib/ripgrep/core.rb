require 'open3'

module Ripgrep
  class Core
    def self.exec(*args, opts)
      unless opts.class == Hash
        args << opts
        opts = {}
      end
      opts = { dir: '.' }.merge(opts)
      puts "args: #{args}, opts: #{opts}"
      stdout, stderr, status = Open3.capture3('rg', *args, opts[:dir])
      raise Ripgrep::NoMatchError, stderr if status.exitstatus == 1
      unless status.exitstatus == 0
        puts "exit status: #{status.exitstatus}"
        raise Ripgrep::CommandExecutionError, stderr 
      end
      stdout
    end

    def self.version
      self.exec('--version')
    end

    def self.help
      self.exec('--help')
    end
  end
end
