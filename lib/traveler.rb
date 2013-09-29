require_relative 'route'

class Traveler
  def initialize(origin, destination, flights, hourly_rate)
    @origin = origin
    @destination = destination
    @flights = flights
    @hourly_rate = hourly_rate
  end

  def route
    @_route ||= calculate_route
  end

  def to_s
    output = "\n"
    time_minutes = 0
    route.flights.each_with_index do |flight, index|
      flight_start_time = time_minutes
      flight_end_time = time_minutes + flight.transit_time * 60
      output += "#{index+1}. #{flight}\t#{time_format flight_start_time} #{time_format flight_end_time} #{money_format cost_for(flight)}\n"
      time_minutes += flight.time * 60
    end
    output.to_s + "\nTotal Cost: #{money_format cost_for(route)}\n\n"
  end

  private

  def money_format number
    "$%.2f" % number
  end

  def time_format minutes
    hours = (minutes / 60).to_i
    minutes = (minutes.to_i) % 60
    "%d:%02d" % [hours, minutes]
  end

  attr_accessor :city_under_investigation, :hourly_rate

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
      cost_to_get_to_neighbor_from_current = cost_to_get_to[city] + cost_for(flight)
      if evaluated?(neighbor) && cost_to_get_to_neighbor_from_current >= cost_to_get_to[neighbor]
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

  def cost_for trip
    trip.cost + trip.time * hourly_rate
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
