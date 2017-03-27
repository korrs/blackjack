class Card
  def cost
    kind = self.to_i
    cost = kind
    cost = 10 if (kind > 10 && kind < 14)
    cost = 11 if kind == 14
    cost
  end
end
