require_relative '../lib/flight'
require 'minitest/autorun'

describe Flight do
  it 'can be created with individual arguments' do
    flight
  end

  it 'cannot be created with no arguments' do
    lambda {
      Flight.new
    }.must_raise ArgumentError
  end

  it 'sets the origin city' do
    flight.origin.must_equal omaha
  end

  it 'sets the destination city' do
    flight.destination.must_equal miami
  end

  it 'sets the cost' do
    flight.cost.must_equal cost
  end

  describe '#layover_time' do
    it 'is 3 hours between non-hub cities' do
      flight = flight_with_hub_cities(false, false)
      flight.layover_time.must_equal 3
    end

    it 'is 2 hours between a non-hub and a hub' do
      flight = flight_with_hub_cities(false, true)
      flight.layover_time.must_equal 2
    end

    it 'is 2 hours between a hub and a non-hub' do
      flight = flight_with_hub_cities(true, false)
      flight.layover_time.must_equal 2
    end

    it 'is 1 hours between hub cities' do
      flight = flight_with_hub_cities(true, true)
      flight.layover_time.must_equal 1
    end
  end

  it 'calculates the total time' do
    flight.time.must_equal expected_total_time
  end

  it 'calculates the total distance' do
    flight.distance.must_equal distance(miami, omaha)
  end

  private

  def flight_with_hub_cities(city_a_hub, city_b_hub)
    Flight.new(City.new("a", 0, 0, city_a_hub),
               City.new("b", 1, 1, city_b_hub),
               10)
  end

  def expected_total_time
    expected_air_time + expected_runway_time + expected_layover_time
  end

  def expected_air_time
    distance(omaha, miami) / average_flight_speed
  end

  def distance(a, b)
    Math.sqrt((a.latitude - b.latitude)**2 + (a.longitude - b.longitude)**2) * 4
  end

  def average_flight_speed
    450
  end

  def expected_runway_time
    20.0 / 60.0
  end

  def expected_layover_time
    2
  end

  def flight
    Flight.new omaha, miami, cost
  end

  def omaha
    @_omaha = City.new "Omaha(NE)", 367, 209, false
  end

  def miami
    @_miami = City.new "Miami(FL)", 626, 443, true
  end

  def cost
    409
  end
end
