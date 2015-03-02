require_relative 'api'
require_relative 'null_api'
require_relative 'notifier'

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
    Notifier.new(current_uri).run
  end

  private

  def current_uri
    api.current_uri
  end
end
