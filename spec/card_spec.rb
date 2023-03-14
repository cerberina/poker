require "rspec"
require "poker_cerberina"

describe PokerCerberina::Card do
  describe "#initialize" do
    it "should raise an exception for empty rank" do
      expect { PokerCerberina::Card.new("", "S") }.to raise_error("Invalid value for rank")
    end
    it "should raise an exception for empty suit" do
      expect { PokerCerberina::Card.new("K", "") }.to raise_error("Invalid value for suit")
    end
    it "should raise an exception for invalid rank" do
      expect { PokerCerberina::Card.new("1", "D") }.to raise_error("Invalid value for rank")
    end
    it "should raise exception for invalid suit" do
      expect { PokerCerberina::Card.new("9", "X") }.to raise_error("Invalid value for suit")
    end
  end

  describe "#<=>" do
    it "is equal for cards with same rank" do
      dama_s = PokerCerberina::Card.new("Q", "S")
      dama_d = PokerCerberina::Card.new("Q", "D")
      expect(dama_s == dama_d).to eq true
    end
    it "shouldn't be equal for cards with different rank but same suit" do
      dama_s = PokerCerberina::Card.new("Q", "S")
      valet_s = PokerCerberina::Card.new("J", "S")
      expect(dama_s == valet_s).to eq false
    end

    context "compare cards with different ranks" do
      it "should returns false" do
        ace_h = PokerCerberina::Card.new("A", "H")
        two_c = PokerCerberina::Card.new("2", "C")
        expect(two_c > ace_h).to eq false
      end
      it "should return true" do
        ace_h = PokerCerberina::Card.new("A", "H")
        two_c = PokerCerberina::Card.new("2", "C")
        expect(two_c < ace_h).to eq true
      end
    end
  end
end
