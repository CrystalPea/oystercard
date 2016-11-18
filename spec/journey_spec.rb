require 'journey'

describe Journey do
subject(:journey) { described_class.new }
let(:entry_station) {double :entry_station}
let(:exit_station) {double :exit_station}

  it "entry station is nil by default" do
    expect(journey.entry_station).to eq nil
  end


  it "exit station is nil by default" do
    expect(journey.exit_station).to eq nil
  end

  it "registers if the journey started" do
    journey.register_entry_station(:entry_station)
    expect(journey.ongoing?).to eq true
  end

  it "registers exit station" do
    journey.register_exit_station(:exit_station)
    expect(journey.exit_station).to eq :exit_station
  end

  it "is calculates minimum fare for complete journeys" do
    journey.register_entry_station(:entry_station)
    journey.register_exit_station(:exit_station)
    expect(journey.fare).to eq Journey::MINIMUM_FARE
  end

  it "is calculates penalty fare for incomplete journeys" do
    journey.register_entry_station(:entry_station)
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

end
