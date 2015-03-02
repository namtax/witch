require_relative 'api'

class Witch
  attr_reader :api

  def initialize(api = Api.new)
    @api = api
  end

  def run
    api.visit
    api.search
    api.click_top_hit
  end

  def current_uri
    api.current_uri
  end
end
