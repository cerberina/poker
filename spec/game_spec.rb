require "rspec"
require "poker_cerberina"

def card(rank, suit)
  PokerCerberina::Card.new(rank, suit)
end

describe PokerCerberina::Game do
  describe "#initialize" do
    context "raise an exception if number of players out of range" do
      it "for 11 players" do
        expect { PokerCerberina::Game.new(11) }.to raise_error("Invalid number of players. Should be 2-10")
      end
      it "for 1 player" do
        expect { PokerCerberina::Game.new(1) }.to raise_error("Invalid number of players. Should be 2-10")
      end
    end
    context "doesn't raise an exception if number of players in range" do
      it "for 2 players" do
        expect { PokerCerberina::Game.new(2) }.not_to raise_error #("Invalid number of players. Should be 2-10")
      end
      it "for 10 player" do
        expect { PokerCerberina::Game.new(10) }.not_to raise_error #("Invalid number of players. Should be 2-10")
      end
    end
    it "is true that new players are created for new game" do
      game = PokerCerberina::Game.new(5)

      expect(game.players.size).to eq 5
    end
    it "is true that deck isn't empty for new game" do
      game = PokerCerberina::Game.new(7)

      expect(game.deck != []).to eq true
    end
  end

  describe "#deal" do
    it "is true that each player have exact same number of cards after dealing as was dealed" do
      game = PokerCerberina::Game.new(7)
      game.deal(2)
      game.players.each do |player|
        expect(player.hand.size).to eq 2
      end
    end
  end
  #PokerCerberina::Game.new(2)
  describe "#winning_player" do
    it "" do
      players = []
      player_a = PokerCerberina::Player.new
      player_a.hand = PokerCerberina::Hand.new ([card("7", "♠︎"), card("10", "♣︎"), card("10", "♦︎"), card("9", "♠︎"), card("4", "♣︎")])
      players << player_a
      player_b = PokerCerberina::Player.new
      player_b.hand = PokerCerberina::Hand.new ([card("7", "♣︎"), card("7", "♥︎"), card("4", "♦︎"), card("9", "♥︎"), card("A", "♥︎")])
      players << player_b
      players.max_by(&:best_combination)
      expect(players.max_by(&:best_combination)).to eq player_a
    end
  end
end
