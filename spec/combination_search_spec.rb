require "rspec"
require "poker_cerberina"

describe PokerCerberina::CombinationSearch do
  describe "find_pairs" do
    it "returns true" do
      search = PokerCerberina::CombinationSearch.new
      hand = PokerCerberina::Hand.new([
        PokerCerberina::Card.new("K", "♠︎"),
        PokerCerberina::Card.new("K", "♣︎"),
        PokerCerberina::Card.new("K", "♥︎"),
        PokerCerberina::Card.new("2", "♠︎"),
        PokerCerberina::Card.new("2", "♣︎"),
      ])
      expect(search.find_pairs(hand)).to eq([PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("2", "♠︎"), PokerCerberina::Card.new("2", "♣︎")])])
    end
  end
end
