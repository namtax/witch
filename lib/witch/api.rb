require 'mechanize'

module Witch
  class Api
    attr_reader :agent

    def initialize(agent = Mechanize.new)
      @agent = agent
    end

    def visit
      agent.get(Configuration.search_page) rescue nil
    end

    def search
      search_form.q = Configuration.search_term
      search_form.submit
    end

    def click_top_hit
      top_link.click
    end

    def current_uri
      page.uri.to_s
    end

    private

    def search_form
      forms.detect{ |f| f.action[/search/] }
    end

    def forms
      page.forms
    end

    def page
      agent.page
    end

    def top_link
      Mechanize::Page::Link.new(top_link_node, agent, page)
    end

    def top_link_node
      page
        .search('div#res')
        .css('a')
        .first
    end
  end
end