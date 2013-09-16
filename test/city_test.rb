require_relative '../lib/city'
require 'minitest/autorun'

describe City do
  describe 'initialization' do
    it 'can be created with a data string' do
      City.new data: "Omaha(NE)\t\t(367,209)"
    end

    it 'can be created with individual arguments' do
      City.new name: "Gotham", longitude: 304, latitude: 192, hub: true
    end

    it 'cannot be created with no arguments' do
      lambda {
        City.new
      }.must_raise ArgumentError
    end
  end

  describe 'when instantiated with a string' do
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

    private
    def omaha
      @_omaha = City.new data: "Omaha(NE)\t\t(367,209)"
    end

    def miami
      @_miami = City.new data: "*Miami(FL)\t\t(626,443)"
    end
  end

  describe 'when instantiated with a hash and data string' do
    it 'overwrites data string values with explicit hash values' do
      city = City.new name: 'Gotham', data: "Omaha(NE)\t\t(367,209)"
      city.name.must_equal 'Gotham'
    end
  end
end
