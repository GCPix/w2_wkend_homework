require('Minitest/autorun')
require('Minitest/rg')

require_relative('../song')

require('pry')

class SongTest < Minitest::Test

  def setup
    @song = Song.new("You and Me")
  end

    def test_read_song
      assert_equal("You and Me", @song.title)
    end
end
