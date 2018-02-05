RSpec.describe StaircaseToSector::Models::Base do

  let(:model) do
    Class.new do
      include StaircaseToSector::Models::Base
    end
  end

  subject { model.new(path) }

  skip "StaircaseToSector::Feeder need all files, including directories" do
    describe '#skip?' do
      context 'with a png file' do
        let(:path) { 'a/file.png' }
        it 'should not be skipped' do
          expect(subject).to_not be_skip
        end
      end

      context 'with a json file' do
        let(:path) { 'a/file.json' }
        it 'should not be skipped' do
          expect(subject).to_not be_skip
        end
      end

      context 'with other file type' do
        let(:path) { 'a/file.pdf' }
        it 'should skip it' do
          expect(subject).to be_skip
        end
      end
    end
  end
end
