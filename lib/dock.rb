class Dock

  attr_reader :name,
              :max_rental_time,
              :rental_log

  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @rental_log = {}
  end

  def rent(boat, renter)
    if rental_log.keys.include?(boat)
      rental_log[boat] += renter
    else
      rental_log[boat] = renter
    end
  end

end
