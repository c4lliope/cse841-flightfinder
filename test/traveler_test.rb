require 'minitest/autorun'
require_relative '../lib/traveler'
require_relative '../app/factories/flight_factory'
require_relative '../app/factories/city_factory'

describe Traveler do
  describe '#new' do
    it 'takes an origin and a destination, and a list of flights' do
      Traveler.new origin, destination, flights
    end
  end

  describe '#route' do
    it 'returns a valid route' do
      skip
      route.must_be_kind_of Route
      route.origin.must_equal origin
      route.destination.must_equal destination
      route.must_be(&:valid?)
    end
  end

  private

  def route
    traveler.route
  end

  def traveler
    @_traveler ||= Traveler.new origin, destination, flights
  end

  def flights
    @_flights ||= FlightFactory.new(cities).import_from_file('data/flights.txt')
  end

  def origin
    cities.first
  end

  def destination
    cities[36]
  end

  def cities
    @_cities ||= CityFactory.import_from_file('data/cities.txt')
  end
end
