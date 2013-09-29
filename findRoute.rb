require_relative 'app/factories/city_factory'
require_relative 'app/factories/flight_factory' 
require_relative 'lib/traveler'

class Program
  def initialize
    (origin_index, destination_index, hourly_rate) = ARGV
    @origin = cities[origin_index.to_i]
    @destination = cities[destination_index.to_i]
    @hourly_rate = hourly_rate.to_f
  end

  def run
    puts traveler.to_s
  end

  private
  attr_reader :origin, :cities, :destination, :hourly_rate

  def traveler
    @_traveler ||= Traveler.new origin, destination, flights, hourly_rate, flight_factory.lowest_cost_per_mile
  end

  def cities
    @_cities ||= CityFactory.import_from_file 'data/cities.txt'
  end

  def flights
    flight_factory.flights
  end

  def flight_factory
    @_flight_factory ||= FlightFactory.new(cities).import_from_file 'data/flights.txt'
  end
end

Program.new.run

