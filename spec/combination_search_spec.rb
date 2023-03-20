require "rspec"
require "poker_cerberina"

describe PokerCerberina::CombinationSearch do
  describe "find_kiker" do
    it "finds the kiker in combinations with different ranks" do
      search = PokerCerberina::CombinationSearch.new
      hand = PokerCerberina::Hand.new([
        PokerCerberina::Card.new("A", "♠︎"),
        PokerCerberina::Card.new("2", "♠︎"),
        PokerCerberina::Card.new("K", "♣︎"),
        PokerCerberina::Card.new("K", "♥︎"),
        PokerCerberina::Card.new("2", "♣︎"),
      ])
      expect(search.find_kiker(hand)).to eq([PokerCerberina::Combination.new("kiker",
                                                                             PokerCerberina::Card.new("A", "♠︎"))])
    end
    it "finds the kiker in combination where several cards has same rank" do
      search = PokerCerberina::CombinationSearch.new
      hand = PokerCerberina::Hand.new([
        PokerCerberina::Card.new("K", "♠︎"),
        PokerCerberina::Card.new("2", "♠︎"),
        PokerCerberina::Card.new("K", "♣︎"),
        PokerCerberina::Card.new("K", "♥︎"),
        PokerCerberina::Card.new("2", "♣︎"),
      ])
      expect(search.find_kiker(hand)).to eq([PokerCerberina::Combination.new("kiker",
                                                                             PokerCerberina::Card.new("K", "♠︎"))])
    end
  end
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
  describe "find_full_house" do
    it "finds the full_house" do
      search = PokerCerberina::CombinationSearch.new
      hand = PokerCerberina::Hand.new([
        PokerCerberina::Card.new("K", "♠︎"),
        PokerCerberina::Card.new("2", "♠︎"),
        PokerCerberina::Card.new("K", "♣︎"),
        PokerCerberina::Card.new("K", "♥︎"),
        PokerCerberina::Card.new("2", "♣︎"),
      ])
      expect(search.find_full_house(hand)).to eq([PokerCerberina::Combination.new("full_house",
                                                                                  [PokerCerberina::Card.new("K", "♠︎"),
                                                                                   PokerCerberina::Card.new("2", "♠︎"),
                                                                                   PokerCerberina::Card.new("K", "♣︎"),
                                                                                   PokerCerberina::Card.new("K", "♥︎"),
                                                                                   PokerCerberina::Card.new("2", "♣︎")])])
    end
    it "doesn't find the full_house" do
      search = PokerCerberina::CombinationSearch.new
      hand = PokerCerberina::Hand.new([
        PokerCerberina::Card.new("K", "♠︎"),
        PokerCerberina::Card.new("3", "♠︎"),
        PokerCerberina::Card.new("K", "♣︎"),
        PokerCerberina::Card.new("K", "♥︎"),
        PokerCerberina::Card.new("2", "♣︎"),
      ])
      expect(search.find_full_house(hand)).to eq([])
    end
  end
  describe "find_flush" do
    it "finds the flush" do
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
      expect(search.find_flush(hand)).to eq([PokerCerberina::Combination.new("flush",
                                                                             [PokerCerberina::Card.new("K", "♠︎"),
                                                                              PokerCerberina::Card.new("3", "♠︎"),
                                                                              PokerCerberina::Card.new("2", "♠︎"),
                                                                              PokerCerberina::Card.new("A", "♠︎"),
                                                                              PokerCerberina::Card.new("Q", "♠︎")])])
    end
    it "doesn't find the flush" do
      search = PokerCerberina::CombinationSearch.new
      hand = PokerCerberina::Hand.new([
        PokerCerberina::Card.new("K", "♠︎"),
        PokerCerberina::Card.new("2", "♠︎"),
        PokerCerberina::Card.new("3", "♠︎"),
        PokerCerberina::Card.new("Q", "♠︎"),
        PokerCerberina::Card.new("A", "♥︎"),
      ])
      #require "debug"
      #debugger
      expect(search.find_flush(hand)).to eq([])
    end
  end
  describe "find_straight" do
    it "finds the straight" do
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
      expect(search.find_straight(hand)).to eq([PokerCerberina::Combination.new("straight",
                                                                                [PokerCerberina::Card.new("K", "♠︎"),
                                                                                 PokerCerberina::Card.new("3", "♠︎"),
                                                                                 PokerCerberina::Card.new("2", "♠︎"),
                                                                                 PokerCerberina::Card.new("A", "♠︎"),
                                                                                 PokerCerberina::Card.new("Q", "♠︎")])])
    end
    it "doesn't find the straight" do
      search = PokerCerberina::CombinationSearch.new
      hand = PokerCerberina::Hand.new([
        PokerCerberina::Card.new("K", "♠︎"),
        PokerCerberina::Card.new("2", "♠︎"),
        PokerCerberina::Card.new("3", "♠︎"),
        PokerCerberina::Card.new("Q", "♠︎"),
        PokerCerberina::Card.new("A", "♥︎"),
      ])
      #require "debug"
      #debugger
      expect(search.find_straight(hand)).to eq([])
    end
  end
end
