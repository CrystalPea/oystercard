require './lib/station'

describe Station do
  #subject(:station) {described_class.new}
  let(:station_name) {double :station_name}
  let(:zone1) {double :zone1}

  it "should be given name upon initialization" do
  station = Station.new(:station_name, :zone1)
    expect(station.name).to eq :station_name
  end

  it "should be given a zone upon initialization" do
    station = Station.new(:station_name, :zone1)
    expect(station.zone).to eq :zone1
  end



end
