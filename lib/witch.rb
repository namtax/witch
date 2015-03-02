require_relative 'api'
require_relative 'null_api'

class Witch
  attr_reader :api

  def initialize(api = Api.new)
    @api = api
  end

  def run
    api.visit || @api = NullApi.new
    api.search
    api.click_top_hit
  end

  def status
    current_uri || notification
  end

  private

  def current_uri
    "current uri = #{api.current_uri}" if api.current_uri
  end

  def notification
    %q[page request unsuccessful - please try again later]
  end
end
