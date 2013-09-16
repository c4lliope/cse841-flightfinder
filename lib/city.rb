class City
  def initialize(name, longitude, latitude, hub)
    @name = name
    @longitude = longitude
    @latitude = latitude
    @hub = hub
  end

  attr_accessor :name, :latitude, :longitude

  def hub?
    @hub
  end
end
