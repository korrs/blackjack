class Game
  GREETING = 'Сыграем в Блекджек? (Далее - Enter, Выход - Ctrl + C)'
  LINE = '_______________________________________________________'

  attr_reader :dealer, :user, :deck

  def initialize(user = User.new, dealer = Dealer.new, deck = Deck.new )
    @dealer = dealer
    @user = user
    @deck = deck
  end

  def run
    puts GREETING
    gets
    user.set_name
    user.about_cash
    start_game
    2.times { puts LINE }
  end

  private

  def start_game
    initial_deal
    show_hands
    while condition do
      hit_me_or_stand
      show_hands
    end
    show_winner_and_recount
    show_hands(show_all: true)
    rescue run
  end

  def condition
    user.hand.sum < 21 && dealer.hand.sum < 21 \
    && !(dealer.hand.sum >= 17 && dealer.hand.sum < 21 && @user_stand && @deal_count > 0)
  end

  def show_hands(show_all: false)
    puts LINE
    puts show_all ? dealer.hand : dealer.hand[1..-1]
    puts "#{dealer.name}#{": " + dealer.hand.sum.to_s if show_all}"
    puts user.hand
    puts "#{user.name}: #{user.hand.sum}"
    puts LINE
    puts "На твоем счету #{user.money}$" if show_all
  end

   def hit_me_or_stand
    puts "1 - Стоять, 2 - Взять карту"
    input = gets.chomp
    stand = input == "1" ? true : false
    deal(stand: stand)
    @deal_count += 1
  end

  def initial_deal
    @deal_count = 0
    2.times { deal(stand: false) }
  end

  def deal(stand: false)
    dealer.hand.draw(deck.shuffle!, 1) if dealer.hand.sum < 17
    user.hand.draw(deck.shuffle!, 1) unless stand
    @user_stand = stand
  end

  def show_winner_and_recount
    puts "Ничья!" if (user.hand.sum == dealer.hand.sum && dealer.hand.sum < 21)

    if dealer.hand.sum <= 21 &&(dealer.hand.sum > user.hand.sum || user.hand.sum > 21)
      puts "#{dealer.name} выиграл!"
      recount_money(winner: dealer, loser: user)
    else
      puts "#{dealer.name} проиграл!" if user.hand.sum != dealer.hand.sum
    end

    if user.hand.sum <= 21 &&(user.hand.sum > dealer.hand.sum || dealer.hand.sum > 21)
      puts "#{user.name} выиграл!"
      recount_money(winner: user, loser: dealer)
    else
      puts "#{user.name} проиграл!" if user.hand.sum != dealer.hand.sum
    end
  end

  def recount_money(winner: nil, loser: nil)
    winner.money += 10
    loser.money -= 10
  end
end
