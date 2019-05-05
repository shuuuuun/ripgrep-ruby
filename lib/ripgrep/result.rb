module Ripgrep
  class Result
    module Status
      SUCCESS = 0
      NO_MATCH = 1
      ERROR = 2
    end

    attr_reader :raw_result, :raw_error, :exit_status

    def initialize(result, error = '', exit_status: 0)
      @raw_result = result
      @raw_error = error
      @exit_status = exit_status

      # unless [0, 1, 2].include? exit_status
      #   # puts "exit status: #{exit_status}"
      #   raise Ripgrep::ResultError, error 
      # end
      case exit_status
      when Status::SUCCESS
      when Status::NO_MATCH
      when Status::ERROR
        raise Ripgrep::ResultError, error 
      else
        raise Ripgrep::ResultError, error 
      end
    end

    def to_s
      @raw_result.to_s
    end
  end
end
