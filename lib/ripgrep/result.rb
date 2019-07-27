module Ripgrep
  class Result
    module Status
      SUCCESS = 0
      NO_MATCH = 1
      ERROR = 2
    end

    attr_reader :raw_result, :raw_error, :exit_status, :matches

    def initialize(result, error = '', exit_status: 0)
      @raw_result = result
      @raw_error = error
      @exit_status = exit_status

      # TODO: skip when not matching result. like a help or version.
      # $ rg --files で対象ファイルが取れるので、これと比較してmatch結果かどうか見るのがいいかも
      @matches = result.split("\n").map do |line|
        file, *body = line.split(':')
        Match.new file: file, body: body.join(':'), raw_line: line
      end

      case exit_status
      when Status::SUCCESS
      when Status::NO_MATCH
      when Status::ERROR
        raise Ripgrep::ResultError, error 
      else
        raise Ripgrep::ResultError, error 
      end
    end

    def lines
      @raw_result.to_s.split("\n")
    end

    def to_s
      @raw_result.to_s
    end
  end
end
