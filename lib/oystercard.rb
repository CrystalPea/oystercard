require_relative './journeylog'

class OysterCard
  MAXIMUM_LIMIT = 90
  MINIMUM_LIMIT = 1
  attr_reader :balance
  attr_accessor :journeylog_klass

  def initialize(journey, journeylog)
    @journeylog_klass = journeylog.new(journey)
    @balance = 0
  end

  def top_up(value)
    raise "Cannot top up: £#{MAXIMUM_LIMIT} limit would be exceeded" if limit_exceeded?(value)
    self.balance += value
  end


  def touch_in(entry_station)
    raise "Error: Insufficient balance, please top up." if insufficient_funds?
    if (self.journeylog_klass.journey_instance != nil) && !!(self.journeylog_klass.incomplete_journey)
      self.journeylog_klass.register_journey(nil)
      deduct((self.journeylog_klass.journey_history.last)[:fare])
    end
    self.journeylog_klass.start_journey(entry_station)
  end

  def touch_out(exit_station)
    self.journeylog_klass.register_journey(exit_station)
    deduct((self.journeylog_klass.journey_history.last)[:fare])
  end

  private

  attr_writer :balance

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
