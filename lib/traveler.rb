class Traveler
  def initialize(origin, destination, flights)
    @origin = origin
    @destination = destination
    @flights = flights
  end

  def route
    flight = Flight.new(origin, destination, 10)
    Route.new [flight]
  end

  private
  attr_reader :origin, :destination, :flights
end
