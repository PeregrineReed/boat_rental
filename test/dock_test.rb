require 'minitest/autorun'
require 'minitest/pride'
require './lib/boat'
require './lib/renter'
require './lib/dock'

class DockTest < Minitest::Test

  def setup
    @dock = Dock.new("The Rowing Dock", 3)
    @kayak_1 = Boat.new(:kayak, 20)
    @kayak_2 = Boat.new(:kayak, 20)
    @sup_1 = Boat.new(:standup_paddle_board, 15)
    @patrick = Renter.new("Patrick Star", "4242424242424242")
    @eugene = Renter.new("Eugene Crabs", "1313131313131313")
  end

  def test_it_exists
    assert_instance_of Dock, @dock
  end

  def test_it_has_a_name
    assert_equal "The Rowing Dock", @dock.name
  end

  def test_it_has_a_max_rental_time
    assert_equal 3, @dock.max_rental_time
  end

  def test_it_can_log_boat_rentals
    @dock.rent(@kayak_1, @patrick)
    @dock.rent(@kayak_2, @patrick)
    @dock.rent(@sup_1, @eugene)

    boat_rentals = {
      @kayak_1 => @patrick,
      @kayak_2 => @patrick,
      @sup_1 => @eugene
    }

    assert_equal boat_rentals, @dock.rental_log
  end

  def test_it_can_charge_for_boat_rentals
    @dock.rent(@kayak_1, @patrick)
    @dock.rent(@sup_1, @eugene)
    2.times { @kayak_1.add_hour }
    5.times { @kayak_1.add_hour }

    kayak_receipt = {
       card_number: "4242424242424242",
       amount: 40
    }

    sup_receipt = {
     card_number: "1313131313131313",
     amount: 45
    }

    assert_equal kayak_receipt, @dock.charge(@kayak_1)
    assert_equal sup_receipt, @dock.charge(@sup_1)
  end

end
