require 'mechanize'

class Witch
  attr_reader :agent

  SEARCH_PAGE = %q[http://google.com/]
  SEARCH_TERM = %q[which university]

  def initialize
    @agent = Mechanize.new
  end

  def run
    visit
    search
    top_link.click
  end

  def current_uri
    page.uri.to_s
  end

  private

  def visit
    agent.get(SEARCH_PAGE)
  end

  def search
    search_form.q = SEARCH_TERM
    search_form.submit
  end

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
