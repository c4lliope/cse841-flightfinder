require_relative '../../lib/flight'
class FlightFactory
  def initialize(cities)
    @cities = cities
  end

  def import_from_file(path)
    flights = []
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
    flights
  end

  private
  attr_accessor :cities
end
