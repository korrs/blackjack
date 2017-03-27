class Player
  attr_accessor :money, :hand, :name

  def initialize(hand, name, money)
    @name = name
    @hand = hand
    @money = money
  end

end
