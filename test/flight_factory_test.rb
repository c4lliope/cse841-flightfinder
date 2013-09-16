require_relative '../app/factories/flight_factory'
require 'minitest/autorun'

describe FlightFactory do
  describe '#new' do
    it 'accepts a list of cities' do
      FlightFactory.new([omaha, miami])
    end

    it 'accepts an empty list of cities' do
      FlightFactory.new([])
    end

    it 'breaks if not supplied arguments' do
      lambda {
        FlightFactory.new
      }.must_raise ArgumentError
    end
  end

  describe '#import_from_file' do
    def file
      'data/flights.txt'
    end

    it 'will break if input file has more cities than provided' do
      lambda {
        FlightFactory.new([omaha]).import_from_file file
      }.must_raise RuntimeError
    end

    it 'imports many flights' do
      (flights.count > cities.count).must_equal true
    end

    it 'does not import zero-cost flights' do
      flights.select do |flight|
        flight.cost == 0
      end.count.must_equal 0
    end

    it 'imports correct costs' do
      flight = flights.find do |f|
        f.origin == cities[1] &&
        f.destination == cities[2]
      end
      flight.cost.must_equal 393
    end

    private
    def flights
      @_flights ||= FlightFactory.new(cities).import_from_file 'data/flights.txt'
    end

    def cities
      @_cities ||= CityFactory.import_from_file 'data/cities.txt'
    end
  end

  private
  def omaha
    @_omaha = City.new "Omaha(NE)", 367, 209, false
  end

  def miami
    @_miami = City.new "Miami(FL)", 626, 443, true
  end
end
