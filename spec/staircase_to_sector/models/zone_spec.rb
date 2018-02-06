RSpec.describe StaircaseToSector::Models::Zone do
  let(:path)    { 'a/path/whatever/where/Staircases/A Staircase/Zones/A Sector/A Zone-=-Architecte.png' }
  let(:context) {{ root_path: 'a/path/whatever/where', context: {}}}

  subject { described_class.new(path, context) }

  it 'ensure model act as expected' do
    expect(subject.name.to_s).to        eql('A Zone-=-Architecte')
    expect(subject.extension).to        eql('.png')
    expect(subject.full_name.to_s).to   eql('A Zone-=-Architecte.png')

    expect(subject.root_path.to_s).to   eql('a/path/whatever/where')
    expect(subject.source_path.to_s).to eql('a/path/whatever/where/Staircases/A Staircase/Zones/A Sector/A Zone-=-Architecte.png')
    expect(subject.dir_path.to_s).to    eql('Staircases/A Staircase/Zones/A Sector')
  end
end
