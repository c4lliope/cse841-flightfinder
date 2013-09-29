require 'minitest/autorun'
require_relative '../lib/traveler'
require_relative '../app/factories/flight_factory'
require_relative '../app/factories/city_factory'

describe Traveler do
  describe '#new' do
    it 'takes an origin and a destination, a list of flights, and an hourly rate' do
      Traveler.new origin, destination, flights, hourly_rate
    end

    def flights
      [Flight.new(origin, destination, cost)]
    end
    def cost
      10
    end
  end

  describe '#route' do
    describe 'for a one-flight trip' do
      it 'finds a valid route' do
        route.valid?.must_equal true
      end

      it 'starts at the origin' do
        route.origin.must_equal origin
      end

      it 'ends at the destination' do
        route.destination.must_equal destination
      end

      it "only uses the provided flights" do
        route.flights.each do
          |flight| flights.must_include flight
        end
      end

      it 'only uses one flight' do
        route.flights.count.must_equal 1
      end

      private

      def route
        @_route ||= traveler.route
      end

      def traveler
        @_traveler ||= Traveler.new origin, destination, flights, hourly_rate
      end

      def flights
        @_flights ||= [
          Flight.new(origin, cities[5], cost),
          valid_flight,
          Flight.new(cities[3], cities[8], cost),
          Flight.new(cities[9], destination, cost),
        ]
      end

      def valid_flight
        Flight.new(origin, destination, cost)
      end

      def cost
        10
      end
    end

    describe 'for a two-flight trip' do
      it 'finds a valid route' do
        route.valid?.must_equal true
      end

      it 'starts at the origin' do
        route.origin.must_equal origin
      end

      it 'ends at the destination' do
        route.destination.must_equal destination
      end

      it "only uses the provided flights" do
        route.flights.each do
          |flight| flights.must_include flight
        end
      end

      it 'only uses two flights' do
        route.flights.count.must_equal 2
      end

      private

      def route
        @_route ||= traveler.route
      end

      def traveler
        @_traveler ||= Traveler.new origin, destination, flights, hourly_rate
      end

      def flights
        @_flights ||= [
          Flight.new(intermediate, destination, cost),
          Flight.new(origin, cities[4], cost),
          Flight.new(origin, intermediate, cost),
          Flight.new(cities[3], cities[7], cost),
          Flight.new(cities[8], destination, cost),
        ]
      end

      def intermediate
        @_intermediate ||= cities[10]
      end

      def valid_flight
        Flight.new(origin, destination, cost)
      end

      def cost
        10
      end
    end

    describe 'for longer trips' do
      it 'returns a valid route' do
        route.valid?.must_equal true
      end

      it 'starts at the origin' do
        route.origin.must_equal origin
      end

      it 'ends at the destination' do
        route.destination.must_equal destination
      end

      it "only uses the provided flights" do
        route.flights.each do
          |flight| flights.must_include flight
        end
      end
      private

      def origin
        @_origin ||= cities.sample
      end

      def destination
        @_destination ||= begin
                            city = cities.sample
                            while city == origin
                              city = cities.sample
                            end
                            city
                          end
      end
    end

    private

    def route
      @_route ||= traveler.route
    end

    def traveler
      @_traveler ||= Traveler.new origin, destination, flights, hourly_rate
    end

    def flights
      @_flights ||= FlightFactory.new(cities).import_from_file('data/flights.txt')
    end
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

  def hourly_rate
    12.5
  end
end
