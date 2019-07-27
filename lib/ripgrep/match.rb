module Ripgrep
  class Match
    attr_reader :file, :body, :raw_line

    def initialize(file:, body:, raw_line:)
      @file = file
      @body = body
      @raw_line = raw_line
    end

    def to_s
      raw_line
    end

    def to_json
      { file: file, body: body, raw_line: raw_line }.to_json
    end
  end
end
