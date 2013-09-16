class Flight
  def initialize(origin, destination, cost)
    @origin = origin
    @destination = destination
    @cost = cost
  end

  attr_accessor :origin, :destination, :cost
end
