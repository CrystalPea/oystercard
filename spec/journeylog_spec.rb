require 'journeylog'

describe JourneyLog do
  subject(:journeylog) { described_class.new(Journey) }
  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}

  it "has an empty journey history by default" do
    expect(journeylog.journey_history).to eq ([])
  end

  it "starts a new journey" do
    journeylog.start_journey(:entry_station)
    expect(journeylog.journey_instance).not_to be nil
  end


  it "remembers a single journey" do
    journeylog.start_journey(:entry_station)
    journeylog.register_journey(:exit_station)
    expect(journeylog.journey_history).to eq ([{entry_station: :entry_station, exit_station: :exit_station, fare: 1}])
  end

  it "registers an incomplete journey if user forgot to touch out" do
    journeylog.start_journey(:entry_station)
    journeylog.start_journey(:entry_station)
    expect(journeylog.journey_history).to eq ([{entry_station: :entry_station, exit_station: nil, fare: 6}])
  end

  it "registers an incomplete journey if user forgot to touch in" do
    journeylog.register_journey(:exit_station)
    expect(journeylog.journey_history).to eq ([{entry_station: nil, exit_station: :exit_station, fare: 6}])
  end

end
