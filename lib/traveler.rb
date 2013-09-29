class Traveler
  def initialize(origin, destination, flights)
    @origin = origin
    @destination = destination
    @flights = flights
  end

  def route
    result = flights.find { |f| f.origin == origin && f.destination == destination }
    if result
      return Route.new [result]
    end
    other_cities = cities.reject do |city|
      city == origin || city == destination
    end
    other_cities.each do |city|
      first_leg = flights.find {|f| f.origin == origin && f.destination == city }
      second_leg = flights.find {|f| f.origin == city && f.destination == destination }
      if first_leg && second_leg
        return Route.new [first_leg, second_leg]
      end
    end
  end

  def acceptable?(route)
    route.origin == origin &&
      route.destination == destination &&
      route.valid?
  end
  private
  attr_reader :origin, :destination, :flights

  def heuristic_cost_estimate
    100000000000
  end

  def cities
    @_cities ||= flights.map(&:origin) + flights.map(&:destination)
  end

end
