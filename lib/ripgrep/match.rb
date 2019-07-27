module Ripgrep
  class Match
    attr_reader :file, :body

    def initialize(file:, body:)
      @file = file
      @body = body
    end
    # TODO: make more rich and useful interface.
  end
end
