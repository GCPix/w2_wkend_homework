class Room
attr_reader :name, :price

attr_accessor :guests, :songs, :guest, :takings, :room_limit, :bar

  def initialize(name)
    @name = name
    @guests = []
    @songs = []
    @room_limit = 5
    @price = 2.50
    @takings = 0.00
    @bar = bar

  end

    def add_guest(guest)
      #tidyied this up once I got it all working to take out a bunch of nested sttatements but not sure that was the best thing.
      date = Date.today.to_s.reverse
      if check_room_limit == true &&
      guest.room == nil &&
      check_guest_has_money(guest) == true

            guest_pays_entry(guest)

            @guests.push(guest)

            guest.add_room_detail(@name)

            guest.add_visit_to_guest(date, @price)

    end
    end

    def add_song(song)
      @songs.push(song)
    end

    def remove_guest(guest)
      @guests.delete(guest)
      guest.remove_room_detail
    end

    def check_room_limit

      if @guests.length < 5
        #i always tell it to return either. somwhere in my head i think there is a shorter way?
        return true
      else
        return false
      end
    end

    def check_guest_has_money(guest)
      if guest.money >= @price
        return true
      else
        return false
      end

    end

    def guest_pays_entry(guest)

      guest.money -= @price
      @takings += @price
    end

    def guest_pays_bar(guest, baritem)

      guest.money -= baritem.price
      @takings += baritem.price
    end
    def check_favourite_song(guest)
      @songs.each{|song|
        if song.title == guest.favourite_song
          return true
        else
          return false
        end
      }
    end
#even if this works it isn't really correct.  I need them to enter a date in correct format to match up to visit
    def guest_buys_from_bar(guest, baritem)
      if guest.money > baritem.price
          date = Date.today.to_s.reverse

          guest.add_bar_item_to_guest_visit(date, baritem)

          guest_pays_bar(guest, baritem)

      end
    end

end
