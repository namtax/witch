describe Witch do
  let(:expected_uri) { %q[http://university.which.co.uk/] }

  describe '#run' do
    it 'navigates to which page' do
      subject.run
      expect(subject.current_uri).to eq expected_uri
    end
  end
end
