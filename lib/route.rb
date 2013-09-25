class Route
  def initialize(flights)
    @flights = flights
  end

  attr_reader :flights

  def cities
    [origin] + flights.map(&:destination)
  end

  def cost
    flights.map(&:cost).reduce(&:+)
  end

  def origin
    first_flight.origin
  end

  def destination
    last_flight.destination
  end

  def time
    flights.map(&:time).reduce(&:+)
  end

  def valid?
    flight_origins = flights.map(&:origin)
    flight_destinations = flights.map(&:destination)
    flight_origins.drop(1) == flight_destinations[0...-1]
  end

  private

  def first_flight
    flights.first
  end

  def last_flight
    flights.last
  end
end
