module Witch
  class Notifier
    attr_reader :uri

    def initialize(uri)
      @uri = uri
    end

    def run
      current_uri || error
    end

    private

    def current_uri
      "current uri = #{uri}" if uri
    end

    def error
      %q[page request unsuccessful - please try again later]
    end
  end
end
