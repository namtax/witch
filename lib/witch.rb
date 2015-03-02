require 'witch/configuration'
require 'witch/notifier'
require 'witch/null_ui'
require 'witch/ui'

module Witch
  attr_reader :ui

  def self.run
    ui.visit || @ui = NullUi.new
    ui.search
    ui.click_top_hit
  end

  def self.status
    Notifier.new(ui.current_uri).run
  end

  def self.ui
    @ui ||= Ui.new
  end
end

