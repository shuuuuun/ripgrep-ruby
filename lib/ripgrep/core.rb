require 'open3'

module Ripgrep
  class Core
    def self.exec(*args, verbose: false)
      stdout, stderr, status = Open3.capture3('rg', *args)
      puts "exit status: #{status.exitstatus}" if verbose
      unless status.exited?
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

    def self.files
      self.exec('--files').to_a
    end
  end
end
