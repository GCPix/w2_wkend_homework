require('Minitest/autorun')
require('Minitest/rg')

require_relative('../bar')


require('pry')

class  BarTest < Minitest::Test
  def setup
    @item1 = BarItem.new("food", "burger", 0.50)
    @item2 = BarItem.new("drink", "beer", 0.25)
  end

  def test_get_type
    assert_equal("food", @item1.type)
  end

  def test_get_name
    assert_equal("burger", @item1.name)
  end

  def test_get_price
    assert_equal(0.50, @item1.price)
  end
end
