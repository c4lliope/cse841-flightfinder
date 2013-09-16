class City
  def initialize(string)
    @name = string.split("\t").first
    @longitude = string.split(/[\(,\)]/)[3]
    @latitude = string.split(/[\(,\)]/)[4]
    @hub = string.chars.first == '*'
  end

  attr_accessor :name, :longitude, :latitude

  def hub?
    @hub
  end
end
