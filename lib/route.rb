class Route
  def initialize(flights)
    @flights = flights
  end

  attr_reader :flights

  def cities
    [origin] + flights.map(&:destination)
  end

  def cost
    flight_costs.reduce(&:+)
  end

  def origin
    first_flight.origin
  end

  def destination
    last_flight.destination
  end

  private
  def flight_costs
    flights.map(&:cost)
  end

  def first_flight
    flights.first
  end

  def last_flight
    flights.last
  end
end
