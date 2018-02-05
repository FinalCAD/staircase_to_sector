RSpec.describe StaircaseToSector::Processors::Metadata::Base do
  let(:instance) do
    Class.new do
      include StaircaseToSector::Processors::Metadata::Base
    end.new
  end

  describe '#write' do
    let(:file) { instance.send(:write, %W[a_file .txt], 'A Content') }

    it 'should write the file' do
      expect(Pathname(file)).to be_exist
      expect(file.read).to eql('A Content')
    end

    after do
      file.close
      file.unlink
    end
  end
end
