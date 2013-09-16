require_relative '../app/factories/city_factory'
require 'minitest/autorun'

describe CityFactory do
  describe '#create' do
    it 'creates cities with a data string' do
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
  end

  describe '#import_from_file' do
    it 'imports cities' do
      cities.each do |city|
        city.must_be_kind_of City
      end
    end

    it 'imports multiple cities' do
      cities.count.must_equal 60
    end

    it 'imports correct city data' do
      cities.must_include omaha
      cities.must_include miami
    end

    private
    def cities
      @_cities ||= CityFactory.import_from_file('data/cities.txt')
    end
  end

  private
  def omaha
    @_omaha = CityFactory.create "Omaha(NE)\t\t(367,209)"
  end

  def miami
    @_miami = CityFactory.create "*Miami(FL)\t\t(626,443)"
  end
end
