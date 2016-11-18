require_relative './journey'

class OysterCard
  MAXIMUM_LIMIT = 90
  MINIMUM_LIMIT = 1
  attr_reader :balance, :journey_instance, :journey_history, :journey_klass

  def initialize(journey)
    @balance = 0
    @journey_klass = journey
    @journey_history = []
  end

  def top_up(value)
    raise "Cannot top up: £#{MAXIMUM_LIMIT} limit would be exceeded" if limit_exceeded?(value)
    self.balance += value
  end


  def touch_in(entry_station)
    raise "Error: Insufficient balance, please top up." if insufficient_funds?
    if (journey_instance != nil) && !!(self.journey_instance.entry_station)
      deduct(journey_instance.fare)
      register_journey(nil)
    end
    instantiate_new_journey
    self.journey_instance.register_entry_station(entry_station)
  end

  def touch_out(exit_station)
    instantiate_new_journey if journey_instance == nil
    self.journey_instance.register_exit_station(exit_station)
    deduct(self.journey_instance.fare)
    register_journey(exit_station)
    self.journey_instance = nil
  end

  def instantiate_new_journey
    @journey_instance = journey_klass.new
  end



  private

  attr_writer :balance, :journey_history, :journey_instance, :journey_klass

  def register_journey(exit_station)
    self.journey_history << {self.journey_instance.entry_station=>exit_station}
  end

  def limit_exceeded?(value)
    self.balance + value > MAXIMUM_LIMIT
  end

  def insufficient_funds?
    self.balance < MINIMUM_LIMIT
  end

  def deduct(value)
    self.balance -= value
  end

end
