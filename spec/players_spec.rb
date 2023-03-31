require "rspec"
require "poker_cerberina"

describe "#initialize" do
  it "is true that player has random name" do
    player1 = PokerCerberina::Player.new
    player2 = PokerCerberina::Player.new
    expect(player1.name).not_to eq player2.name
  end
end

describe "#best_combination" do
  context "" do
    it "returns the best combination" do
      player = PokerCerberina::Player.new
      player.hand = PokerCerberina::Hand.new ([PokerCerberina::Card.new("2", "♠︎"),
                                               PokerCerberina::Card.new("K", "♠︎"),
                                               PokerCerberina::Card.new("K", "♣︎"),
                                               PokerCerberina::Card.new("Q", "♥︎"),
                                               PokerCerberina::Card.new("2", "♣︎")])
      expected_combination = PokerCerberina::Combination.new("two_pairs", [PokerCerberina::Card.new("2", "♠︎"),
                                                                           PokerCerberina::Card.new("K", "♠︎"),
                                                                           PokerCerberina::Card.new("K", "♣︎"),
                                                                           PokerCerberina::Card.new("2", "♣︎")])
      expect(player.best_combination).to eq expected_combination
    end
  end
  it "returns top_card if no other combination exist" do
    player = PokerCerberina::Player.new
    player.hand = PokerCerberina::Hand.new ([PokerCerberina::Card.new("2", "♠︎"),
                                             PokerCerberina::Card.new("6", "♠︎"),
                                             PokerCerberina::Card.new("K", "♣︎"),
                                             PokerCerberina::Card.new("Q", "♥︎"),
                                             PokerCerberina::Card.new("4", "♣︎")])
    expected_combination = PokerCerberina::Combination.new("top_card", PokerCerberina::Card.new("K", "♣︎"))
    expect(player.best_combination).to eq expected_combination
  end
end
