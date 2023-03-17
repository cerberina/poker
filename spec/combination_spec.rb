require "rspec"
require "poker_cerberina"

describe PokerCerberina::Combination do
  describe "#<=>" do
    context "compare two pairs" do
      it "is equal for pairs with same rank" do
        combination_a = PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎")])
        combination_b = PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("Q", "♠︎"), PokerCerberina::Card.new("Q", "♣︎")])
        expect(combination_a <=> combination_b).to eq 0
      end
      it "should returns false" do
        combination_a = PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎")])
        combination_b = PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("Q", "♠︎"), PokerCerberina::Card.new("Q", "♣︎")])
        expect(combination_b < combination_a).to eq false
      end
      it "should return true" do
        combination_a = PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎")])
        combination_b = PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("Q", "♠︎"), PokerCerberina::Card.new("Q", "♣︎")])
        expect(combination_b > combination_a).to eq true
      end
    end
    context "compare two sets" do
      it "is equal for sets with same rank" do
        combination_a = PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎"), PokerCerberina::Card.new("J", "♠︎")])
        combination_b = PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♣︎"), PokerCerberina::Card.new("J", "♠︎")])
        expect(combination_a <=> combination_b).to eq 0
      end
      it "should returns false" do
        combination_a = PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎"), PokerCerberina::Card.new("J", "♠︎")])
        combination_b = PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎"), PokerCerberina::Card.new("Q", "♠︎")])
        expect(combination_b < combination_a).to eq false
      end
      it "should return true" do
        combination_a = PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎"), PokerCerberina::Card.new("J", "♠︎")])
        combination_b = PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎"), PokerCerberina::Card.new("Q", "♠︎")])
        expect(combination_b > combination_a).to eq true
      end
    end
    context "compare two quads" do
      it "is equal for quads with same rank" do
        combination_a = PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎"), PokerCerberina::Card.new("J", "♠︎"), PokerCerberina::Card.new("J", "♣︎")])
        combination_b = PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♣︎"), PokerCerberina::Card.new("J", "♠︎"), PokerCerberina::Card.new("J", "♥︎")])
        expect(combination_a <=> combination_b).to eq 0
      end
      it "should returns false" do
        combination_a = PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎"), PokerCerberina::Card.new("J", "♠︎"), PokerCerberina::Card.new("J", "♣︎")])
        combination_b = PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎"), PokerCerberina::Card.new("Q", "♠︎"), PokerCerberina::Card.new("Q", "♣︎")])
        expect(combination_b < combination_a).to eq false
      end
      it "should return true" do
        combination_a = PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎"), PokerCerberina::Card.new("J", "♠︎"), PokerCerberina::Card.new("J", "♣︎")])
        combination_b = PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎"), PokerCerberina::Card.new("Q", "♠︎"), PokerCerberina::Card.new("Q", "♣︎")])
        expect(combination_b > combination_a).to eq true
      end
    end
  end
  describe "#==" do
    context "when 2 pairs have same suit" do
      it "isn't equal for pairs with different rank" do
        combination_a = PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎")])
        combination_b = PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎")])
        expect(combination_a == combination_b).to eq false
      end
      it "is equal for pairs with same rank" do
        combination_a = PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("2", "♠︎"), PokerCerberina::Card.new("2", "♣︎")])
        combination_b = PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("2", "♠︎"), PokerCerberina::Card.new("2", "♣︎")])
        expect(combination_a == combination_b).to eq true
      end
    end
    context "when 2 sets have same suit" do
      it "isn't equal for sets with different rank" do
        combination_a = PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎"), PokerCerberina::Card.new("J", "♠︎")])
        combination_b = PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎"), PokerCerberina::Card.new("Q", "♠︎")])
        expect(combination_a == combination_b).to eq false
      end
      it "is equal for sets with same rank" do
        combination_a = PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎"), PokerCerberina::Card.new("J", "♠︎")])
        combination_b = PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎"), PokerCerberina::Card.new("J", "♠︎")])
        expect(combination_a == combination_b).to eq true
      end
    end
    context "when 2 quads have same suit" do
      it "isn't equal for quads with different rank" do
        combination_a = PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎"), PokerCerberina::Card.new("J", "♠︎"), PokerCerberina::Card.new("J", "♣︎")])
        combination_b = PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎"), PokerCerberina::Card.new("Q", "♠︎"), PokerCerberina::Card.new("Q", "♣︎")])
        expect(combination_a == combination_b).to eq false
      end
      it "is equal for quads with same rank" do
        combination_a = PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎"), PokerCerberina::Card.new("Q", "♠︎"), PokerCerberina::Card.new("Q", "♣︎")])
        combination_b = PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎"), PokerCerberina::Card.new("Q", "♠︎"), PokerCerberina::Card.new("Q", "♣︎")])
        expect(combination_a == combination_b).to eq true
      end
    end
  end
end
