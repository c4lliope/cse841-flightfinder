require_relative '../../lib/city'

module CityFactory
  def self.create data
    @data = data
    City.new name, longitude, latitude, hub?
  end

  def self.import_from_file(filepath)
    cities = []
    IO.foreach(filepath) do |data|
      cities.push create data
    end
    cities
  end

  private
  module_function

  def data
    @data
  end

  def name
    data.scan(/[\w\(\)]+/).first
  end

  def hub?
    data.chars.first == '*'
  end

  def latitude
    location.last
  end

  def longitude
    location.first
  end

  def location
    location_string = data.split("\t").last
    coord_strings = location_string.scan(/\d+/)
    coord_strings.map(&:to_i)
  end
end
