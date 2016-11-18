class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def ongoing?
    !!entry_station
  end

  def register_entry_station(entry_station)
    self.entry_station = entry_station
  end

  def register_exit_station(exit_station)
    self.exit_station = exit_station
  end

  def forget_entry_station
    self.entry_station = nil
  end

  def forget_exit_station
    self.exit_station = nil
  end

  def fare
    return PENALTY_FARE unless ongoing? && !!exit_station
    MINIMUM_FARE
  end

  private
  attr_writer :entry_station, :exit_station

end
