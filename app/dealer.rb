class Dealer < Player
  DEFAULT_NAME = "Диллер"

  def initialize(hand = Hand.new)
    super(hand, DEFAULT_NAME, 100)
  end

end
