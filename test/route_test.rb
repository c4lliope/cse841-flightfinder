require 'minitest/autorun'
require_relative '../lib/route'

describe Route do
  describe '#new' do
    it 'takes a list of flights' do
      Route.new flights
    end
  end

  describe '#cities' do
    it 'returns the list of cities' do
      route.cities.must_equal cities
    end
  end

  describe '#cost' do
    it 'computes the correct cost' do
      route.cost.must_equal single_flight_cost * num_flights
    end
  end

  describe '#origin' do
    it 'returns the origin city' do
      route.origin.must_equal origin
    end
  end

  describe '#destination' do
    it 'returns the destination city' do
      route.destination.must_equal destination
    end
  end

  describe '#time' do
    it 'computes the correct total time' do
      route.time.must_equal route_time
    end
  end

  describe '#valid?' do
    it 'returns false when flights do not line up' do
      cities = 4.times.map { |n| city_named "City #{n}" }
      flights = [flight_between(cities[0], cities[1]),
                 flight_between(cities[2], cities[3])]
      Route.new(flights).valid?.must_equal false
    end

    it 'returns true when flights line up' do
      cities = 4.times.map { |n| city_named "City #{n}" }
      flights = [flight_between(cities[0], cities[1]),
                 flight_between(cities[1], cities[2]),
                 flight_between(cities[2], cities[3])]
      Route.new(flights).valid?.must_equal true
    end
  end

  private

  def city_named name
    City.new name, 0, 0, true
  end

  def flight_between origin, destination
    Flight.new origin, destination, 0
  end

  def route_time
    flights.map(&:time).reduce(&:+)
  end

  def total_flight_distance
    flights.map(&:distance).reduce(&:+)
  end

  def flight_speed
    Flight.average_speed
  end

  def route
    @_route ||= Route.new flights
  end

  def flights
    flights = []
    cities.each_with_index do |city, index|
      next_city = cities[index + 1] || next
      flights << Flight.new(city, next_city, single_flight_cost)
    end
    flights
  end

  def cities
    @_cities ||= [origin, layovers, destination].flatten
  end

  def origin
    @_origin ||= City.new "Originapolis", 0, 0, true
  end

  def layovers
    [
      City.new("New Trenton", 75, 75, true),
      City.new("Middle of Nowhere", 50, 50, false)
    ]
  end

  def destination
    @_destination ||= City.new "Destinatown", 42, 1024, false
  end

  def single_flight_cost
    1000
  end

  def num_flights
    cities.count - 1
  end
end
