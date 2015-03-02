require 'witch/api'
require 'witch/configuration'
require 'witch/null_api'
require 'witch/notifier'

module Witch
  attr_reader :api

  def self.run
    api.visit || @api = NullApi.new
    api.search
    api.click_top_hit
  end

  def self.status
    Notifier.new(api.current_uri).run
  end

  def self.api
    @api ||= Api.new
  end
end

