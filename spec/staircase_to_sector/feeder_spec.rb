require 'ostruct'

RSpec.describe StaircaseToSector::Feeder do
  let(:store) { FileModel::Store::Memory.instance }

  subject do
    Class.new do
      include StaircaseToSector::Feeder
    end.new(store)
  end

  class SimpleFileModel
    include StaircaseToSector::Models::Base
  end

  context 'Add a Staircase' do
    # let(:model) { SimpleFileModel.new('spec/fixtures/archive/input/Staircases/Staircase Name 1') }

    [
      'spec/fixtures/archive/input/Staircases',
      'spec/fixtures/archive/input/Staircases/Staircase Name 1/Sectors',
      'spec/fixtures/archive/input/Staircases/Staircase Name 1/Zones/R+1'
    ].each do |path_to_ignore|
      it { expect(subject.append(SimpleFileModel.new(path_to_ignore))).to eql(false) }
    end

    it do
      model = SimpleFileModel.new('spec/fixtures/archive/input/Staircases/Staircase Name 1')

      # Add Staircase
      expect {
        expect(subject.append(model)).to eql(true)
      }.to change {
        store.models.keys
      }.from([]).to(['Staircase Name 1'])

      # Add Sector
      path = "spec/fixtures/archive/input/Staircases/Staircase Name 1/Sectors/R+1.json"
      model = SimpleFileModel.new(path)
      staircase = store.models['Staircase Name 1']

      expect {
        expect(subject.append(model)).to eql(true)
      }.to change {
        staircase.sectors.keys
      }.from([]).to(['R+1'])

      path = "spec/fixtures/archive/input/Staircases/Staircase Name 1/Sectors/RDC.json"
      model = SimpleFileModel.new(path)
      staircase = store.models['Staircase Name 1']

      expect {
        expect(subject.append(model)).to eql(true)
      }.to change {
        staircase.sectors.keys
      }.from(['R+1']).to(['R+1','RDC'])

      # Add Zones
      path = "spec/fixtures/archive/input/Staircases/Staircase Name 1/Zones/R+1/Logement 12-11-=-Architecte.png"
      model = SimpleFileModel.new(path)
      sector = store.models['Staircase Name 1'].sectors['R+1']

      expect {
        expect(subject.append(model)).to eql(true)
      }.to change {
        sector.zones.keys
      }.from([]).to(['Logement 12-11-=-Architecte'])
    end
  end
end
