class City
  def initialize(name, longitude, latitude, hub)
    @name = name
    @longitude = longitude
    @latitude = latitude
    @hub = hub
  end

  attr_accessor :name, :latitude, :longitude

  def distance_to other
    raw_distance_to(other) * distance_scaling_factor
  end

  def hub?
    @hub
  end

  def ==(other)
    other.name == name &&
      other.latitude == latitude &&
      other.longitude == longitude
  rescue
    false
  end

  def raw_distance_to other
    Math.sqrt((longitude - other.longitude)**2 +
              (latitude - other.latitude)**2)
  end

  def distance_scaling_factor
    4
  end
end
