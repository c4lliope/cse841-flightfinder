class Flight
  def initialize(origin, destination, cost)
    @origin = origin
    @destination = destination
    @cost = cost
  end

  attr_accessor :origin, :destination, :cost

  def time
    air_time + runway_time + layover_time
  end

  def distance
    origin.distance_to destination
  end

  def layover_time
    3 - number_of_hub_cities
  end

  private

  def number_of_hub_cities
    [origin, destination].count { |city| city.hub? }
  end

  def air_time
    distance / average_speed
  end

  def average_speed
    450
  end

  def runway_time
    20.0 / 60.0
  end
end
