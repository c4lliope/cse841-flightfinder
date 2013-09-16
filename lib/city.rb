class City
  def initialize(options)
    @name = options[:name]
    @longitude = options[:longitude]
    @latitude = options[:latitude]
    @hub = options[:hub]
    @data = options[:data]
  end

  def name
    @name ||= data.split("\t").first
  end

  def hub?
    @hub ||= data.chars.first == '*'
  end

  def latitude
    @latitude ||= location.last
  end

  def longitude
    @longitude ||= location.first
  end

  private

  attr_accessor :data

  def location
    @location ||= begin
                    location_string = data.split("\t").last
                    coord_strings = location_string.scan(/\d+/)
                    coord_strings.map(&:to_i)
                  end
  end
end
