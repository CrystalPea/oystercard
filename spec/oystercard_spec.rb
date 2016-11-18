require 'oystercard'

describe OysterCard do
  subject(:oystercard) {described_class.new(Journey)}

  describe "#top_up" do
    it "should increase the balance by top_up value" do
      oystercard.top_up(10)
      expect(oystercard.balance).to eq 10
    end

    it "should raise an error if max. limit is exceeeded" do
      message = "Cannot top up: £#{OysterCard::MAXIMUM_LIMIT} limit would be exceeded"
      expect {oystercard.top_up(100)}.to raise_error(message)
    end
  end

  context "journey" do
    let(:entry_station) {double :entry_station}
    let(:exit_station) {double :exit_station}

    it "has an empty journey history by default" do
      expect(oystercard.journey_history).to eq ([])
    end

    it "instantiates new journey on touch in" do
      oystercard.top_up(10)
      oystercard.touch_in(:entry_station)
      expect(oystercard.journey_instance).not_to be nil
    end

    it "remembers multiple journeys" do
        oystercard.top_up(10)
        5.times { oystercard.touch_in(:entry_station)
        oystercard.touch_out(:exit_station) }
      expect(oystercard.journey_history).to eq ([{:entry_station=>:exit_station}, {:entry_station=>:exit_station},
        {:entry_station=>:exit_station}, {:entry_station=>:exit_station}, {:entry_station=>:exit_station}])
    end

    describe "#touch_in" do

      it "refuses to let you touch in unless the balance is at least £#{OysterCard::MINIMUM_LIMIT}" do
        message = "Error: Insufficient balance, please top up."
        expect {oystercard.touch_in(:entry_station)}.to raise_error(message)
      end
    end

    it "charges penalty fare if user forgot to touch out" do
      oystercard.top_up(10)
      oystercard.touch_in(:entry_station)
      expect{oystercard.touch_in(:entry_station)}.to change{oystercard.balance}
    end

    it "registers an incomplete journey if user forgot to touch in" do
      oystercard.top_up(10)
      oystercard.touch_in(:entry_station)
      oystercard.touch_in(:entry_station)
      expect(oystercard.journey_history).to eq ([{:entry_station=>nil}])
    end


      it "deducts a fare on touch out" do
        oystercard.top_up(10)
        oystercard.touch_in(:entry_station)
        expect {oystercard.touch_out(:exit_station)}.to change{oystercard.balance}
      end
    end
  end

end
