require "rspec"
require "poker_cerberina"

describe PokerCerberina::Combination do
  describe "#<=>" do
    context "compare two pairs" do
      it "is equal for pairs with same rank" do
        compination_a = PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎")])
        combination_b = PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("Q", "♠︎"), PokerCerberina::Card.new("Q", "♣︎")])
        expect(compination_a <=> combination_b).to eq 0
      end
      #move to checks for #== (same for sets and quads)
      it "isn't equal for pairs with different rank but same suit" do
        compination_a = PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎")])
        combination_b = PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎")])
        expect(compination_a == combination_b).to eq false
      end
      it "should returns false" do
        compination_a = PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎")])
        combination_b = PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("Q", "♠︎"), PokerCerberina::Card.new("Q", "♣︎")])
        expect(combination_b < compination_a).to eq false
      end
      it "should return true" do
        compination_a = PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎")])
        combination_b = PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("Q", "♠︎"), PokerCerberina::Card.new("Q", "♣︎")])
        expect(combination_b > compination_a).to eq true
      end
    end
    context "compare two sets" do
      it "is equal for sets with same rank" do
        compination_a = PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎"), PokerCerberina::Card.new("J", "♠︎")])
        combination_b = PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♣︎"), PokerCerberina::Card.new("J", "♠︎")])
        expect(compination_a <=> combination_b).to eq 0
      end
      it "isn't equal for sets with different rank but same suit" do
        compination_a = PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎"), PokerCerberina::Card.new("J", "♠︎")])
        combination_b = PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎"), PokerCerberina::Card.new("Q", "♠︎")])
        expect(compination_a == combination_b).to eq false
      end
      it "should returns false" do
        compination_a = PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎"), PokerCerberina::Card.new("J", "♠︎")])
        combination_b = PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎"), PokerCerberina::Card.new("Q", "♠︎")])
        expect(combination_b < compination_a).to eq false
      end
      it "should return true" do
        compination_a = PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎"), PokerCerberina::Card.new("J", "♠︎")])
        combination_b = PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎"), PokerCerberina::Card.new("Q", "♠︎")])
        expect(combination_b > compination_a).to eq true
      end
    end
    context "compare two quads" do
      it "is equal for quads with same rank" do
        compination_a = PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎"), PokerCerberina::Card.new("J", "♠︎"), PokerCerberina::Card.new("J", "♣︎")])
        combination_b = PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♣︎"), PokerCerberina::Card.new("J", "♠︎"), PokerCerberina::Card.new("J", "♥︎")])
        expect(compination_a <=> combination_b).to eq 0
      end
      it "isn't equal for quads with different rank but same suit" do
        compination_a = PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎"), PokerCerberina::Card.new("J", "♠︎"), PokerCerberina::Card.new("J", "♣︎")])
        combination_b = PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎"), PokerCerberina::Card.new("Q", "♠︎"), PokerCerberina::Card.new("Q", "♣︎")])
        expect(compination_a == combination_b).to eq false
      end
      it "should returns false" do
        compination_a = PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎"), PokerCerberina::Card.new("J", "♠︎"), PokerCerberina::Card.new("J", "♣︎")])
        combination_b = PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎"), PokerCerberina::Card.new("Q", "♠︎"), PokerCerberina::Card.new("Q", "♣︎")])
        expect(combination_b < compination_a).to eq false
      end
      it "should return true" do
        compination_a = PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎"), PokerCerberina::Card.new("J", "♠︎"), PokerCerberina::Card.new("J", "♣︎")])
        combination_b = PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎"), PokerCerberina::Card.new("Q", "♠︎"), PokerCerberina::Card.new("Q", "♣︎")])
        expect(combination_b > compination_a).to eq true
      end
    end
  end
end
