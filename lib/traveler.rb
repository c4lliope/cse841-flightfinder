class Traveler
  def initialize(origin, destination, flights)
    @origin = origin
    @destination = destination
    @flights = flights
  end

  def route
    @_route ||= calculate_route
  end

  private

  attr_accessor :city_under_investigation

  def calculate_route
    until unevaluated_cities.empty?
      city_under_investigation = next_city_to_investigate
      if city_under_investigation == destination
        best_path = reconstruct_path(came_from, destination)
        previous_city = best_path.shift
        best_flights = []
        best_path.each do |city|
          best_flights << flights.find {|flight| flight.origin == previous_city && flight.destination == city }
          previous_city = city
        end
        return Route.new best_flights
      end

      unevaluated_cities.delete city_under_investigation
      evaluate city_under_investigation
    end
  end

  def evaluate city
    flights_from(city).each do |flight|
      neighbor = flight.destination
      cost_to_get_to_neighbor_from_current = cost_to_get_to[city] + flight.distance
      already_examined = evaluated?(neighbor) && cost_to_get_to_neighbor_from_current >= cost_to_get_to[neighbor]
      if already_examined
        next
      end

      if !unevaluated_cities.include?(neighbor) || cost_to_get_to_neighbor_from_current < cost_to_get_to[neighbor]
        came_from[neighbor] = city
        cost_to_get_to[neighbor] = cost_to_get_to_neighbor_from_current
        estimated_total_cost_going_through[neighbor] = cost_to_get_to[neighbor] + heuristic_cost_estimate(neighbor, destination)
        add_to_unevaluated neighbor
      end
    end
  end

  def reconstruct_path(came_from, current_city)
    if came_from.include? current_city
      reconstruct_path(came_from, came_from[current_city]) + [current_city]
    else
      [current_city]
    end
  end

  attr_reader :origin, :destination, :flights

  def evaluated?(city)
    cost_to_get_to.keys.include? city
  end

  def unevaluated_cities
    @_unevaluated_cities ||= [origin]
  end

  def came_from
    @_came_from ||= {}
  end

  def cost_to_get_to
    @_cost_to_get_to ||= {origin => 0}
  end

  def estimated_total_cost_going_through
    @_estimated_total_cost_going_through ||= {origin => cost_to_get_to[origin] + heuristic_cost_estimate(origin, destination)}
  end

  def next_city_to_investigate
    unevaluated_cities.min { |a, b| estimated_total_cost_going_through[a] <=> estimated_total_cost_going_through[b] }
  end

  def neighbor_cities(city)
    flights.select { |flight| flight.origin = city }.map(&:destination)
  end

  def heuristic_cost_estimate(from, to)
    100000000000
  end

  def cities
    @_cities ||= flights.map(&:origin) + flights.map(&:destination)
  end

  def cost_for_route route
    route.cost + route.time * cost_per_hour
  end

  def cost_per_hour
    12
  end

  def flights_from(city)
    flights.select { |flight| flight.origin == city }
  end

  def add_to_unevaluated neighbor
    unless unevaluated_cities.include? neighbor
      unevaluated_cities << neighbor
    end
  end

  def acceptable?(route)
    route.origin == origin &&
      route.destination == destination &&
      route.valid?
  end
end
