class JourneyLog

attr_reader :journey_history, :journey_instance, :incomplete_journey

  def initialize(journey)
    @journey_klass = journey
    @journey_history = []
    @journey_instance = nil
  end

  def start_journey(entry_station)
    register_journey(nil) if journey_instance != nil
    instantiate_new_journey
    current_journey(entry_station)
    self.journey_instance.register_entry_station(entry_station)
  end

  def instantiate_new_journey
    self.journey_instance = journey_klass.new
  end

  def register_journey(exit_station)
    instantiate_new_journey if journey_instance == nil
    self.journey_instance.register_exit_station(exit_station)
    fare = self.journey_instance.fare
    self.journey_history << { entry_station: incomplete_journey, exit_station: exit_station, fare: fare }
    self.journey_instance = nil
  end

  private
  attr_writer :journey_instance
  attr_accessor :journey_klass

  def current_journey(entry_station)
      #return self.journey_instance = journey_klass.new if journey_instance == nil
      @incomplete_journey = entry_station
  end

end
