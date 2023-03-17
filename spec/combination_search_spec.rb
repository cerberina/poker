require "rspec"
require "poker_cerberina"

describe PokerCerberina::CombinationSearch do
  describe "find_pairs" do
    it "finds the pair" do
      search = PokerCerberina::CombinationSearch.new
      hand = PokerCerberina::Hand.new([
        PokerCerberina::Card.new("K", "♠︎"),
        PokerCerberina::Card.new("2", "♠︎"),
        PokerCerberina::Card.new("K", "♣︎"),
        PokerCerberina::Card.new("K", "♥︎"),
        PokerCerberina::Card.new("2", "♣︎"),
      ])
      expect(search.find_pairs(hand)).to eq([PokerCerberina::Combination.new("pair",
                                                                             [PokerCerberina::Card.new("2", "♠︎"),
                                                                              PokerCerberina::Card.new("2", "♣︎")])])
    end
    it "doesn't find the pair" do
      search = PokerCerberina::CombinationSearch.new
      hand = PokerCerberina::Hand.new([
        PokerCerberina::Card.new("3", "♠︎"),
        PokerCerberina::Card.new("4", "♣︎"),
        PokerCerberina::Card.new("9", "♥︎"),
        PokerCerberina::Card.new("10", "♠︎"),
        PokerCerberina::Card.new("2", "♣︎"),
      ])
      expect(search.find_pairs(hand)).to eq([])
    end
    it "finds 2 pairs" do
      search = PokerCerberina::CombinationSearch.new
      hand = PokerCerberina::Hand.new([
        PokerCerberina::Card.new("K", "♠︎"),
        PokerCerberina::Card.new("2", "♠︎"),
        PokerCerberina::Card.new("Q", "♣︎"),
        PokerCerberina::Card.new("K", "♥︎"),
        PokerCerberina::Card.new("2", "♣︎"),
      ])
      #require "debug"
      #debugger
      expect(search.find_pairs(hand)).to eq([PokerCerberina::Combination.new("pair",
                                                                             [PokerCerberina::Card.new("K", "♠︎"),
                                                                              PokerCerberina::Card.new("K", "♥︎")]),
                                             PokerCerberina::Combination.new("pair",
                                                                             [PokerCerberina::Card.new("2", "♠︎"),
                                                                              PokerCerberina::Card.new("2", "♣︎")])])
    end
  end
  describe "find_sets" do
    it "finds the set" do
      search = PokerCerberina::CombinationSearch.new
      hand = PokerCerberina::Hand.new([
        PokerCerberina::Card.new("K", "♠︎"),
        PokerCerberina::Card.new("2", "♠︎"),
        PokerCerberina::Card.new("K", "♣︎"),
        PokerCerberina::Card.new("K", "♥︎"),
        PokerCerberina::Card.new("2", "♣︎"),
      ])
      expect(search.find_sets(hand)).to eq([PokerCerberina::Combination.new("set",
                                                                            [PokerCerberina::Card.new("K", "♠︎"),
                                                                             PokerCerberina::Card.new("K", "♣︎"),
                                                                             PokerCerberina::Card.new("K", "♥︎")])])
    end
    it "doesn't find the set" do
      search = PokerCerberina::CombinationSearch.new
      hand = PokerCerberina::Hand.new([
        PokerCerberina::Card.new("K", "♠︎"),
        PokerCerberina::Card.new("2", "♠︎"),
        PokerCerberina::Card.new("7", "♣︎"),
        PokerCerberina::Card.new("K", "♥︎"),
        PokerCerberina::Card.new("2", "♣︎"),
      ])
      expect(search.find_sets(hand)).to eq([])
    end
  end
  describe "find_quads" do
    it "finds the quad" do
      search = PokerCerberina::CombinationSearch.new
      hand = PokerCerberina::Hand.new([
        PokerCerberina::Card.new("K", "♠︎"),
        PokerCerberina::Card.new("K", "♦︎"),
        PokerCerberina::Card.new("K", "♣︎"),
        PokerCerberina::Card.new("K", "♥︎"),
        PokerCerberina::Card.new("2", "♣︎"),
      ])
      quad = [PokerCerberina::Combination.new("quad",
                                              [PokerCerberina::Card.new("K", "♠︎"),
                                               PokerCerberina::Card.new("K", "♣︎"),
                                               PokerCerberina::Card.new("K", "♥︎"),
                                               PokerCerberina::Card.new("K", "♦︎")])]
      #require "debug"
      #debugger
      expect(search.find_quads(hand)).to eq(quad)
    end
    it "doesn't find the quad" do
      search = PokerCerberina::CombinationSearch.new
      hand = PokerCerberina::Hand.new([
        PokerCerberina::Card.new("K", "♠︎"),
        PokerCerberina::Card.new("2", "♠︎"),
        PokerCerberina::Card.new("7", "♣︎"),
        PokerCerberina::Card.new("K", "♥︎"),
        PokerCerberina::Card.new("2", "♣︎"),
      ])
      expect(search.find_quads(hand)).to eq([])
    end
  end
  describe "find_fullhouse" do
    it "finds the fullhouse" do
      search = PokerCerberina::CombinationSearch.new
      hand = PokerCerberina::Hand.new([
        PokerCerberina::Card.new("K", "♠︎"),
        PokerCerberina::Card.new("2", "♠︎"),
        PokerCerberina::Card.new("K", "♣︎"),
        PokerCerberina::Card.new("K", "♥︎"),
        PokerCerberina::Card.new("2", "♣︎"),
      ])
      expect(search.find_fullhouse(hand)).to eq([PokerCerberina::Combination.new("fullhouse",
                                                                                 [PokerCerberina::Card.new("K", "♠︎"),
                                                                                  PokerCerberina::Card.new("2", "♠︎"),
                                                                                  PokerCerberina::Card.new("K", "♣︎"),
                                                                                  PokerCerberina::Card.new("K", "♥︎"),
                                                                                  PokerCerberina::Card.new("2", "♣︎")])])
    end
    it "doesn't find the fullhouse" do
      search = PokerCerberina::CombinationSearch.new
      hand = PokerCerberina::Hand.new([
        PokerCerberina::Card.new("K", "♠︎"),
        PokerCerberina::Card.new("3", "♠︎"),
        PokerCerberina::Card.new("K", "♣︎"),
        PokerCerberina::Card.new("K", "♥︎"),
        PokerCerberina::Card.new("2", "♣︎"),
      ])
      expect(search.find_fullhouse(hand)).to eq([])
    end
  end
  describe "find_flash" do
    it "finds the flash" do
      search = PokerCerberina::CombinationSearch.new
      hand = PokerCerberina::Hand.new([
        PokerCerberina::Card.new("K", "♠︎"),
        PokerCerberina::Card.new("2", "♠︎"),
        PokerCerberina::Card.new("3", "♠︎"),
        PokerCerberina::Card.new("Q", "♠︎"),
        PokerCerberina::Card.new("A", "♠︎"),
      ])
      #require "debug"
      #debugger
      expect(search.find_flash(hand)).to eq([PokerCerberina::Combination.new("flash",
                                                                             [PokerCerberina::Card.new("K", "♠︎"),
                                                                              PokerCerberina::Card.new("3", "♠︎"),
                                                                              PokerCerberina::Card.new("2", "♠︎"),
                                                                              PokerCerberina::Card.new("A", "♠︎"),
                                                                              PokerCerberina::Card.new("Q", "♠︎")])])
    end
  end
end
