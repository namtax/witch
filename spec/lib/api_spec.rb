module Witch
  describe Api do
    subject      { Api.new(agent) }
    let(:agent)  { double(page: page) }
    let(:page)   { double }

    describe '#visit' do
      it 'delegates to agent' do
        expect(agent).to receive(:get).with(Configuration.search_page)
        subject.visit
      end

      context 'faulty page' do
        before { allow(agent).to receive(:get).and_raise(SocketError) }
        it     { expect { subject.visit }.to_not raise_error }
      end
    end

    describe '#search' do
      let(:page)   { double(forms: forms) }
      let(:forms)  { [ search ] }
      let(:search) { double(action: 'search') }

      it 'delegates to agent' do
        expect(search).to receive(:q=).with(Configuration.search_term)
        expect(search).to receive(:submit)
        subject.search
      end
    end

    describe '#click_top_hit' do
      let(:results)       { double }
      let(:top_link_node) { double }
      let(:top_link)      { double }

      before do
        allow(page).to receive(:search).with('div#res').and_return(results)
        allow(results).to receive('css').with('a').and_return([top_link_node])
        allow(Mechanize::Page::Link).to receive(:new).with(top_link_node, agent, page).and_return(top_link)
      end

      it 'delegates to mechanize link' do
        expect(top_link).to receive(:click)
        subject.click_top_hit
      end
    end
  end
end