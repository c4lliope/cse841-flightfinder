require_relative '../lib/city'
require 'minitest/autorun'

describe City do
  it 'can be created with individual arguments' do
    City.new "Gotham", 304, 192, true
  end

  it 'cannot be created with no arguments' do
    lambda {
      City.new
    }.must_raise ArgumentError
  end

  it 'sets the city name' do
    omaha.name.must_equal "Omaha(NE)"
  end

  it 'sets the city longitude' do
    omaha.longitude.must_equal 367
  end

  it 'sets the city latitude' do
    omaha.latitude.must_equal 209
  end

  it 'recognizes hub cities' do
    omaha.hub?.must_equal false
    miami.hub?.must_equal true
  end

  it 'calculates the distance between cities correctly' do
    omaha.distance_to(miami).must_equal distance(omaha, miami)
    miami.distance_to(omaha).must_equal distance(omaha, miami)
  end

  private

  def distance(a, b)
    Math.sqrt((a.latitude - b.latitude)**2 + (a.longitude - b.longitude)**2) * 4
  end

  def omaha
    @_omaha = City.new "Omaha(NE)", 367, 209, false
  end

  def miami
    @_miami = City.new "Miami(FL)", 626, 443, true
  end
end
