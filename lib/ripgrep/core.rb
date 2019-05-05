require 'open3'

module Ripgrep
  class Core
    def self.exec(*opts)
      stdout, stderr, status = Open3.capture3('rg', *opts)
      unless [0, 1].include? status.exitstatus
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
