class Guest
attr_reader :name, :favourite_song
attr_accessor :room, :money, :visit_tracker

  def initialize(name, money, favourite_song)
    @name = name
    @room = nil
    @money = money
    @favourite_song = favourite_song
    @visit_tracker = []
  end

  def add_room_detail(room)
    @room = room
  end

  def remove_room_detail
    @room = nil
  end

  def add_visit_to_guest(date, price)
    @visit_tracker.push({visit_date: date, visit_cost: price, items_bought: []})
  end

  def add_bar_item_to_guest_visit(date, item)
    #use enumeration to find correct visit date
    index = @visit_tracker.index{|x| x[:visit_date] == date}

    @visit_tracker[index][:items_bought].push(item)

    end


end
