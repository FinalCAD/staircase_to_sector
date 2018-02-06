RSpec.describe StaircaseToSector::Lib::Point do

  subject { described_class.new(y: 8, x: 40) }

  it 'should provide the right formatted output' do
    expect(subject.to_s).to eql('+40.0+8.0')
  end
end
