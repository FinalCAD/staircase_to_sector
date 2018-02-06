RSpec.describe StaircaseToSector::Models::Staircase do
  let(:path)    { 'a/path/whatever/where/Staircases/A Staircase' }
  let(:context) {{ root_path: 'a/path/whatever/where', context: {}}}

  subject { described_class.new(path, context) }

  it 'ensure model act as expected' do
    expect(subject.name.to_s).to eql('A Staircase')
    expect(subject.full_name.to_s).to eql('A Staircase')

    expect(subject.root_path.to_s).to eql('a/path/whatever/where')
    expect(subject.source_path.to_s).to eql('a/path/whatever/where/Staircases/A Staircase')
    expect(subject.dir_path.to_s).to  eql('Staircases/A Staircase')

    expect(subject.sectors).to eql({})
  end

  describe '#append_sector' do
    let(:sector_path)    { 'a/path/whatever/where/Staircases/A Staircase/Sectors/A Sector.png' }
    let(:sector_context) {{ }}
    let(:sector)         { StaircaseToSector::Models::Sector.new(sector_path, sector_context) }

    it do
      expect {
        subject << sector
      }.to change {
        subject.sectors.keys
      }.from([]).to(['A Sector']).and change {
        subject.number_of_images
      }.by(+1)

      expect(subject.number_of_images).to eql(1)
      expect(subject.sectors['A Sector']).to eql(sector)
      expect(subject.sectors['A Sector'].source_path.to_s).to eql('a/path/whatever/where/Staircases/A Staircase/Sectors/A Sector.png')
    end
  end
end
