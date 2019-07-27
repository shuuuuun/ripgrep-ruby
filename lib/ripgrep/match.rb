module Ripgrep
  class Match
    attr_reader :file, :body

    def initialize(file:, body:)
      @file = file
      @body = body
    end

    def to_s
      { file: file, body: body }.to_json
    end
    # TODO: make more rich and useful interface.
  end
end
