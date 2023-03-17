require "rspec"
require "poker_cerberina"

describe PokerCerberina::Card do
  describe "#initialize" do
    it "should raise an exception for empty rank" do
      expect { PokerCerberina::Card.new("", "♦︎") }.to raise_error("Invalid value for rank")
    end
    it "should raise an exception for empty suit" do
      expect { PokerCerberina::Card.new("K", "") }.to raise_error("Invalid value for suit")
    end
    it "should raise an exception for invalid rank" do
      expect { PokerCerberina::Card.new("1", "♥︎") }.to raise_error("Invalid value for rank")
    end
    it "should raise exception for invalid suit" do
      expect { PokerCerberina::Card.new("9", "X") }.to raise_error("Invalid value for suit")
    end
  end

  describe "#<=>" do
    it "returns 0 for cards with same rank but different suit" do
      card_a = PokerCerberina::Card.new("J", "♦︎")
      card_b = PokerCerberina::Card.new("J", "♣︎")
      expect(card_a <=> card_b).to eq 0
    end
    context "compare cards with different ranks" do
      it "returns false" do
        card_a = PokerCerberina::Card.new("A", "♣︎")
        card_b = PokerCerberina::Card.new("2", "♠︎")
        expect(card_b > card_a).to eq false
      end
      it "return true" do
        card_a = PokerCerberina::Card.new("A", "♣︎")
        card_b = PokerCerberina::Card.new("2", "♠︎")
        expect(card_b < card_a).to eq true
      end
    end
  end

  describe "#==" do
    context "when 2 cards with same rank compared" do
      it "isn't equal for cards with different suit" do
        card_a = PokerCerberina::Card.new("Q", "♦︎")
        card_b = PokerCerberina::Card.new("Q", "♥︎")
        expect(card_a == card_b).to eq false
      end
      it "is equal for cards with same suit" do
        card_a = PokerCerberina::Card.new("Q", "♥︎")
        card_b = PokerCerberina::Card.new("Q", "♥︎")
        require "debug"
        debugger
        expect(card_a == card_b).to eq true
      end
    end
  end
end
