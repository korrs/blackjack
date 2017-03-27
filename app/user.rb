class User < Player

  DEFAULT_NAME = "Игрок"

  def initialize(hand = Hand.new)
    super(hand, DEFAULT_NAME, 100)
  end

  def set_name
    puts "Введи свое имя"
    name = gets.chomp
    self.name = name.empty? ? DEFAULT_NAME : name
  end

  def about_cash
    puts "На счету #{money}$, ставка - 10$"
  end

end
