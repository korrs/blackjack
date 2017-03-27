require_relative '../app/load'

describe Game do
  describe '#start_game' do
    let(:user)   { User.new(Hand.new(user_cards)) }
    let(:dealer) { Dealer.new(Hand.new(dealer_cards)) }
    let(:deck)   { Deck.new }
    let(:game) { Game.new(user, dealer, deck) }

    let(:good_cards) { [Card.new(10), Card.new(10)] }
    let(:poor_cards) { [Card.new(10), Card.new(7)] }
    let(:many_cards) { [Card.new(10), Card.new(10), Card.new(7)] }

    before do
      allow_any_instance_of(Game).to receive(:condition).and_return(false)
      allow_any_instance_of(Game).to receive(:deal).and_return(nil)
    end

    context 'user is winner' do
      let(:user_cards)   { good_cards }
      let(:dealer_cards) { poor_cards }

      it 'increase user money' do
        expect{ game.send(:start_game) }.to change{ user.money }.from(100).to(110)
      end
    end

    context 'dealer is winner' do
      let(:user_cards)   { poor_cards }
      let(:dealer_cards) { good_cards }

      it 'reduce user money' do
        expect{ game.send(:start_game) }.to change{ user.money }.from(100).to(90)
      end
    end

    context 'score is same' do
      let(:user_cards)   { good_cards }
      let(:dealer_cards) { good_cards }

      it 'not change user money' do
        expect{ game.send(:start_game) }.to_not change{ user.money }
      end
    end

    context 'user has score greater than 21' do
      let(:user_cards)   { many_cards }
      let(:dealer_cards) { poor_cards }

      it 'reduce user money' do
        expect{ game.send(:start_game) }.to change{ user.money }.from(100).to(90)
      end
    end

    context 'dealer has score greater than 21' do
      let(:user_cards)   { poor_cards }
      let(:dealer_cards) { many_cards }

      it 'increase user money' do
        expect{ game.send(:start_game) }.to change{ user.money }.from(100).to(110)
      end
    end
  end
end
