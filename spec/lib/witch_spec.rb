describe Witch do
  describe '#run' do
    context 'success' do
      let(:expected_uri) { %q[current uri = http://university.which.co.uk/] }
      it 'navigates to which page' do
        expect(subject.run).to eq expected_uri
      end
    end

    context 'faulty page' do
      before { expect_any_instance_of(Mechanize).to receive(:get).and_raise(SocketError) }
      it 'notifies user' do
        expect(subject.run).to eq 'page request unsuccessful - please try again later'
      end
    end
  end
end
