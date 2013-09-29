require_relative '../../lib/flight'
class FlightFactory
  def initialize(cities)
    @cities = cities
    @flights = []
  end

  def import_from_file(path)
    file = File.new path
    file.each { |line|
      origin_index = file.lineno - 1
      line.split.each_with_index do |cost, destination_index|
        if cost.to_i != 0
          flights.push Flight.new cities[origin_index], cities[destination_index], cost.to_i
        end
      end
    }
    if file.lineno > cities.count
      raise 'Not enough cities provided.'
    end
    self
  end

  def lowest_cost_per_mile
    costs_per_mile = flights.map { |flight| cost_per_mile(flight) }
    costs_per_mile.min
  end

  def cost_per_mile(flight)
    flight.cost.to_f / flight.distance.to_f
  end

  attr_reader :flights

  private
  attr_accessor :cities
end
