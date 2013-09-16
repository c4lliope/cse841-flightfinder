require_relative '../app/factories/city_factory'
require 'minitest/autorun'

describe CityFactory do
  it 'can create cities with a data string' do
    CityFactory.create "Omaha(NE)\t\t(367,209)"
  end

  it 'sets the city name' do
    omaha.name.must_equal "Omaha(NE)"
    miami.name.must_equal "Miami(FL)"
  end

  it 'sets the city longitude' do
    omaha.longitude.must_equal 367
    miami.longitude.must_equal 626
  end

  it 'sets the city latitude' do
    omaha.latitude.must_equal 209
    miami.latitude.must_equal 443
  end

  it 'recognizes hub cities' do
    omaha.hub?.must_equal false
    miami.hub?.must_equal true
  end

  private
  def omaha
    @_omaha = CityFactory.create "Omaha(NE)\t\t(367,209)"
  end

  def miami
    @_miami = CityFactory.create "*Miami(FL)\t\t(626,443)"
  end
end
