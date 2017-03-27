class Hand
  def sum
    cards.map{|card| card.cost }.inject(:+) || 0
  end
end
