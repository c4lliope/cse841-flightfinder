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

  private
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
