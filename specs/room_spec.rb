require('Minitest/autorun')
require('Minitest/rg')

require_relative('../room')
require_relative('../song')
require_relative('../guest')
require_relative('../bar')

require('pry')

class RoomTest < Minitest::Test
  def setup
    @room = Room.new("Rock Room")

    @guest1 = Guest.new("Harmony", 5.00, "You and Me")
    @guest2 = Guest.new("Melody", 2.50, "Here Comes the Sun")
    @guest3 = Guest.new("Ebony", 2.00, "I'll Sleep When I'm Dead")
    @guest4 = Guest.new("Ivory", 5.00, "One More Day")
    @guest5 = Guest.new("Aria", 5.00, "I Don't Want to Miss a Thing")
    @guest6 = Guest.new("Musette", 5.00, "Blood Count")

    @song = Song.new("You and Me")

    @item1 = BarItem.new("food", "burger", 0.50)
    @item2 = BarItem.new("drink", "beer", 0.25)
  end

    def test_read_room_name
      assert_equal("Rock Room", @room.name)
    end

    def test_read_room_guest
      assert_equal([], @room.guests)
    end

    def test_write_room_guest
      @room.guests.push(@guest1)

      assert_equal([@guest1], @room.guests)
    end

    def test_read_room_song
      assert_equal([], @room.songs)
    end

    def test_write_room_song
      @room.songs.push("You and Me")

      assert_equal(["You and Me"], @room.songs)
    end

    def test_add_guest__free
      @room.add_guest(@guest1)

      assert_equal([@guest1], @room.guests)
    end

    def test_add_guest__busy
      @guest1.room = "room"
      @room.add_guest(@guest1)
      assert_equal([], @room.guests)
    end

    def test_add_guest_room_full
      @room.guests = [@guest1, @guest2, @guest3, @guest4, @guest5]

      @room.add_guest(@guest6)

      assert(@room.guests.length == 5 )
    end

    def test_add_guest_room_free
      @room.add_guest(@guest6)

      assert_equal([@guest6], @room.guests )
    end
    def test_remove_guest
      @room.guests = [@guest1]

      @room.remove_guest(@guest1)

        assert_equal([], @room.guests)
    end

    def test_add_song
      @room.add_song(@song)

      assert_equal([@song], @room.songs)
    end

    def test_room_max_below
      actual = @room.check_room_limit

      assert(true, actual)
    end


    def test_room_max_reached
      @room.room_limit = 5
      actual = @room.check_room_limit
      refute(false, actual)
    end

    def test_check_guest_finances__OK
      actual = @room.check_guest_has_money(@guest1)

      assert_equal(true, actual)
    end

    def test_check_guest_finances__not_OK
      actual = @room.check_guest_has_money(@guest3)

      assert_equal(false, actual)
    end

    def test_guest_pays
      @room.guest_pays_entry(@guest1)

      assert_equal(2.50, @guest1.money)
      assert_equal(2.50, @room.takings)
    end

    def test_guest_buys_from_bar__takings

      @room.add_guest(@guest1)
      @room.guest_buys_from_bar(@guest1, @item1)

      assert_equal(3.00, @room.takings)
    end

    def test_guest_buys_from_bar__no_money
      @room.add_guest(@guest2)
      @room.guest_buys_from_bar(@guest2, @item1)

      assert_equal(2.50, @room.takings)
    end

    def test_favourite_song__yes
      @room.add_guest(@guest1)
      @room.add_song(@song)
      actual = @room.check_favourite_song(@guest1)

      assert_equal(true, actual)
  
    end

    def test_favourite_song__no
      @room.add_guest(@guest2)
      @room.add_song(@song)
      actual = @room.check_favourite_song(@guest2)

      assert_equal(false, actual)
    end
end
