require "rspec"
require "poker_cerberina"

describe PokerCerberina::Hand do
  describe "#group_rank" do
    subject(:group_rank) { cards.group_rank }

    context "when all cards are different ranks" do
      let(:cards) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("A", "♠︎"),
          PokerCerberina::Card.new("2", "♠︎"),
          PokerCerberina::Card.new("K", "♣︎"),
          PokerCerberina::Card.new("Q", "♥︎"),
          PokerCerberina::Card.new("5", "♣︎"),
        ])
      end
      let(:expected_hash) do
        { "A" => [PokerCerberina::Card.new("A", "♠︎")],
          "2" => [PokerCerberina::Card.new("2", "♠︎")],
          "K" => [PokerCerberina::Card.new("K", "♣︎")],
          "Q" => [PokerCerberina::Card.new("Q", "♥︎")],
          "5" => [PokerCerberina::Card.new("5", "♣︎")] }
      end
      it "groups each card separately " do
        expect(group_rank).to eq(expected_hash)
      end
    end

    context "when some cards have same ranks" do
      let(:cards) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("A", "♠︎"),
          PokerCerberina::Card.new("A", "♠︎"),
          PokerCerberina::Card.new("K", "♣︎"),
          PokerCerberina::Card.new("K", "♥︎"),
          PokerCerberina::Card.new("K", "♣︎"),
        ])
      end
      let(:expected_hash) do
        { "A" => [PokerCerberina::Card.new("A", "♠︎"), PokerCerberina::Card.new("A", "♠︎")],
          "K" => [PokerCerberina::Card.new("K", "♣︎"), PokerCerberina::Card.new("K", "♥︎"), PokerCerberina::Card.new("K", "♣︎")] }
      end
      it "groups cards with same rank" do
        expect(group_rank).to eq(expected_hash)
      end
    end
  end
  describe "#group_suit" do
    it "" do
    end
  end
  describe "#find_by_rank" do
    it "" do
    end
  end
end
