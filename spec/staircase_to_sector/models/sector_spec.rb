RSpec.describe StaircaseToSector::Models::Sector do
  let(:path)    { 'a/path/whatever/where/Staircases/A Staircase/Sectors/A Sector.png' }
  let(:context) {{ root_path: 'a/path/whatever/where', context: {}}}

  subject { described_class.new(path, context) }

  it 'ensure model act as expected' do
    expect(subject.name.to_s).to        eql('A Sector')
    expect(subject.extension).to        eql('.png')
    expect(subject.full_name.to_s).to   eql('A Sector.png')

    expect(subject.root_path.to_s).to   eql('a/path/whatever/where')
    expect(subject.source_path.to_s).to eql('a/path/whatever/where/Staircases/A Staircase/Sectors/A Sector.png')
    expect(subject.dir_path.to_s).to    eql('Staircases/A Staircase/Sectors')

    expect(subject.zones).to eql({})
  end

  describe '#append_zone' do
    let(:zone_path)    { 'a/path/whatever/where/Staircases/A Staircase/Zones/A Sector/A Zone.png' }
    let(:zone_context) {{ }}
    let(:zone)         { StaircaseToSector::Models::Zone.new(zone_path, zone_context) }

    it do
      expect {
        subject << zone
      }.to change {
        subject.zones.keys
      }.from([]).to(['A Zone'])

      expect(subject.zones['A Zone']).to eql(zone)
      expect(subject.zones['A Zone'].source_path.to_s).to eql('a/path/whatever/where/Staircases/A Staircase/Zones/A Sector/A Zone.png')
    end
  end
end
