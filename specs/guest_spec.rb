require('Minitest/autorun')
require('Minitest/rg')


require_relative('../guest')
require_relative('../bar')

require('pry')

class GuestTest < Minitest::Test

  def setup
    @guest = Guest.new("Harmony", 5.00, "One")
    @baritem1 = BarItem.new("food", "burger", 0.45)
      @baritem2 = BarItem.new("drink", "beer", 0.25)
  end

  def test_read_guest_name
    assert_equal("Harmony", @guest.name)
  end
  def test_update_visit_tracker
    @guest.add_visit_to_guest("15/09/2018", 2.50)
    @guest.add_visit_to_guest("16/09/2018", 2.50)

    assert_equal("15/09/2018", @guest.visit_tracker[0][:visit_date])
    assert_equal(2.50, @guest.visit_tracker[0][:visit_cost])
  end

  def test_update_guest_visit_details
    @guest.add_visit_to_guest("15/09/2018", 2.50)
    @guest.add_visit_to_guest("16/09/2018", 2.50)
    @guest.add_bar_item_to_guest_visit("15/09/2018", @baritem1)
    @guest.add_bar_item_to_guest_visit("16/09/2018", @baritem2)

    assert_equal([@baritem1], @guest.visit_tracker[0][:items_bought])
  end
end
