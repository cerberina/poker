require "rspec"
require "poker_cerberina"

describe PokerCerberina::CombinationSearch do
  let(:search) { described_class.new(hand) }

  describe "#find_kiker" do
    subject(:find_kiker) { search.find_kiker }
    context "when all cards are different ranks" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("A", "♠︎"),
          PokerCerberina::Card.new("2", "♠︎"),
          PokerCerberina::Card.new("K", "♣︎"),
          PokerCerberina::Card.new("K", "♥︎"),
          PokerCerberina::Card.new("2", "♣︎"),
        ])
      end
      let(:expected_combination) do
        PokerCerberina::Combination.new("kiker", PokerCerberina::Card.new("A", "♠︎"))
      end

      it "finds the kiker" do
        expect(find_kiker).to eq([expected_combination])
      end
    end
    context "when several cards have same rank" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("2", "♠︎"),
          PokerCerberina::Card.new("K", "♣︎"),
          PokerCerberina::Card.new("K", "♥︎"),
          PokerCerberina::Card.new("2", "♣︎"),
        ])
      end
      let(:expected_combination) do
        PokerCerberina::Combination.new("kiker", PokerCerberina::Card.new("K", "♠︎"))
      end
      it "finds the kiker in combination where " do
        expect(find_kiker).to eq([expected_combination])
      end
    end
  end
  describe "find_pairs" do
    subject(:find_pairs) { search.find_pairs }
    context "when hand contains pair of cards with the same ranks" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("2", "♠︎"),
          PokerCerberina::Card.new("K", "♣︎"),
          PokerCerberina::Card.new("K", "♥︎"),
          PokerCerberina::Card.new("2", "♣︎"),
        ])
      end
      let(:expected_combination) do
        PokerCerberina::Combination.new("pair",
                                        [PokerCerberina::Card.new("2", "♠︎"),
                                         PokerCerberina::Card.new("2", "♣︎")])
      end
      it "finds the pair" do
        expect(find_pairs).to eq([expected_combination])
      end
    end
    context "when hand contains 2 pair of cards with the same ranks" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("2", "♠︎"),
          PokerCerberina::Card.new("J", "♣︎"),
          PokerCerberina::Card.new("K", "♥︎"),
          PokerCerberina::Card.new("2", "♣︎"),
        ])
      end
      let(:expected_combination) do
        PokerCerberina::Combination.new("pair",
                                        [PokerCerberina::Card.new("K", "♠︎"),
                                         PokerCerberina::Card.new("K", "♥︎")])
      end
      it "finds the highest pair" do
        expect(find_pairs).to eq([expected_combination])
      end
    end
    context "when hand contains 3 pair of cards with the same ranks" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("2", "♠︎"),
          PokerCerberina::Card.new("K", "♣︎"),
          PokerCerberina::Card.new("J", "♥︎"),
          PokerCerberina::Card.new("2", "♣︎"),
          PokerCerberina::Card.new("J", "♣︎"),
        ])
      end
      let(:expected_combination) do
        PokerCerberina::Combination.new("pair",
                                        [PokerCerberina::Card.new("K", "♠︎"),
                                         PokerCerberina::Card.new("K", "♣︎")])
      end
      it "finds the highest pair" do
        expect(find_pairs).to eq([expected_combination])
      end
    end
    context "when all cards are different ranks" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("3", "♠︎"),
          PokerCerberina::Card.new("4", "♣︎"),
          PokerCerberina::Card.new("9", "♥︎"),
          PokerCerberina::Card.new("10", "♠︎"),
          PokerCerberina::Card.new("2", "♣︎"),
        ])
      end
      it "doesn't find the pair" do
        expect(find_pairs).to eq([])
      end
    end
  end
  describe "find_two_pairs" do
    subject(:find_two_pairs) { search.find_two_pairs }
    context "when hand contains pair of cards with the same ranks" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("2", "♠︎"),
          PokerCerberina::Card.new("K", "♣︎"),
          PokerCerberina::Card.new("K", "♥︎"),
          PokerCerberina::Card.new("2", "♣︎"),
        ])
      end
      it "doesn't find the 2 pair" do
        expect(find_two_pairs).to eq([])
      end
    end
    context "when hand contains 2 pair of cards with the same ranks" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("2", "♠︎"),
          PokerCerberina::Card.new("J", "♣︎"),
          PokerCerberina::Card.new("K", "♥︎"),
          PokerCerberina::Card.new("2", "♣︎"),
        ])
      end
      let(:expected_combination) do
        PokerCerberina::Combination.new("two_pairs",
                                        [PokerCerberina::Card.new("K", "♠︎"),
                                         PokerCerberina::Card.new("K", "♥︎"),
                                         PokerCerberina::Card.new("2", "♣︎"),
                                         PokerCerberina::Card.new("2", "♠︎")])
      end
      it "finds the 2 pair" do
        expect(find_two_pairs).to eq([expected_combination])
      end
    end
    context "when hand contains 3 pair of cards with the same ranks" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("2", "♠︎"),
          PokerCerberina::Card.new("K", "♣︎"),
          PokerCerberina::Card.new("J", "♥︎"),
          PokerCerberina::Card.new("2", "♣︎"),
          PokerCerberina::Card.new("J", "♣︎"),
        ])
      end
      let(:expected_combination) do
        PokerCerberina::Combination.new("two_pairs",
                                        [PokerCerberina::Card.new("K", "♠︎"),
                                         PokerCerberina::Card.new("K", "♣︎"),
                                         PokerCerberina::Card.new("J", "♥︎"),
                                         PokerCerberina::Card.new("J", "♣︎")])
      end
      it "finds the highest 2 pair" do
        expect(find_two_pairs).to eq([expected_combination])
      end
    end
    context "when all cards are different ranks" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("3", "♠︎"),
          PokerCerberina::Card.new("4", "♣︎"),
          PokerCerberina::Card.new("9", "♥︎"),
          PokerCerberina::Card.new("10", "♠︎"),
          PokerCerberina::Card.new("2", "♣︎"),
        ])
      end
      it "doesn't find the 2 pair" do
        expect(find_two_pairs).to eq([])
      end
    end
  end
  describe "find_sets" do
    subject (:find_sets) { search.find_sets }
    context "hand contains 3 cards with the same ranks" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("2", "♠︎"),
          PokerCerberina::Card.new("K", "♣︎"),
          PokerCerberina::Card.new("K", "♥︎"),
          PokerCerberina::Card.new("2", "♣︎"),
        ])
      end
      let(:expected_combination) do
        PokerCerberina::Combination.new("set",
                                        [PokerCerberina::Card.new("K", "♠︎"),
                                         PokerCerberina::Card.new("K", "♣︎"),
                                         PokerCerberina::Card.new("K", "♥︎")])
      end
      it "finds the set" do
        expect(find_sets).to eq([expected_combination])
      end
    end
    context "hand contains two sets of 3 cards with the same ranks" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("2", "♠︎"),
          PokerCerberina::Card.new("K", "♣︎"),
          PokerCerberina::Card.new("K", "♥︎"),
          PokerCerberina::Card.new("2", "♣︎"),
          PokerCerberina::Card.new("2", "♥︎"),
        ])
      end
      let(:expected_combination) do
        PokerCerberina::Combination.new("set",
                                        [PokerCerberina::Card.new("K", "♠︎"),
                                         PokerCerberina::Card.new("K", "♣︎"),
                                         PokerCerberina::Card.new("K", "♥︎")])
      end
      it "finds the highest set" do
        expect(find_sets).to eq([expected_combination])
      end
    end
    context "hand doesn't contain 3 cards with the same rank" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("2", "♠︎"),
          PokerCerberina::Card.new("7", "♣︎"),
          PokerCerberina::Card.new("K", "♥︎"),
          PokerCerberina::Card.new("2", "♣︎"),
        ])
      end
      it "doesn't find the set" do
        expect(find_sets).to eq([])
      end
    end
  end
  describe "find_quads" do
    subject (:find_quads) { search.find_quads }
    context "hand contain 4 cards with the same rank" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("K", "♦︎"),
          PokerCerberina::Card.new("K", "♣︎"),
          PokerCerberina::Card.new("K", "♥︎"),
          PokerCerberina::Card.new("2", "♣︎"),
        ])
      end
      let(:expected_combination) do
        [PokerCerberina::Combination.new("quad",
                                         [PokerCerberina::Card.new("K", "♠︎"),
                                          PokerCerberina::Card.new("K", "♣︎"),
                                          PokerCerberina::Card.new("K", "♥︎"),
                                          PokerCerberina::Card.new("K", "♦︎")])]
      end
      it "finds the quad" do
        expect(find_quads).to eq(expected_combination)
      end
    end
    context "hand doesn't contain 4 cards with the same ranks" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("2", "♠︎"),
          PokerCerberina::Card.new("7", "♣︎"),
          PokerCerberina::Card.new("K", "♥︎"),
          PokerCerberina::Card.new("2", "♣︎"),
        ])
      end
      it "doesn't find the quad" do
        expect(find_quads).to eq([])
      end
    end
  end
  describe "find_full_house" do
    subject (:find_full_house) { search.find_full_house }
    context "when hand contain 1 pair of cards with same ranks and set of 3 cards with same ranks" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("2", "♠︎"),
          PokerCerberina::Card.new("K", "♣︎"),
          PokerCerberina::Card.new("K", "♥︎"),
          PokerCerberina::Card.new("2", "♣︎"),
        ])
      end
      let(:expected_combination) do
        [PokerCerberina::Combination.new("full_house",
                                         [PokerCerberina::Card.new("K", "♠︎"),
                                          PokerCerberina::Card.new("2", "♠︎"),
                                          PokerCerberina::Card.new("K", "♣︎"),
                                          PokerCerberina::Card.new("K", "♥︎"),
                                          PokerCerberina::Card.new("2", "♣︎")])]
      end
      it "finds the full_house" do
        expect(find_full_house).to eq(expected_combination)
      end
    end
    context "when hand contain 2 pairs of cards with same ranks and set of 3 cards with same ranks" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("2", "♠︎"),
          PokerCerberina::Card.new("K", "♣︎"),
          PokerCerberina::Card.new("K", "♥︎"),
          PokerCerberina::Card.new("2", "♣︎"),
          PokerCerberina::Card.new("10", "♠︎"),
          PokerCerberina::Card.new("10", "♣︎"),
        ])
      end
      let(:expected_combination) do
        [PokerCerberina::Combination.new("full_house",
                                         [PokerCerberina::Card.new("K", "♠︎"),
                                          PokerCerberina::Card.new("10", "♠︎"),
                                          PokerCerberina::Card.new("K", "♣︎"),
                                          PokerCerberina::Card.new("K", "♥︎"),
                                          PokerCerberina::Card.new("10", "♣︎")])]
      end
      it "finds the full_house" do
        expect(find_full_house).to eq(expected_combination)
      end
    end
    context "when hand contain two sets of 3 cards with same ranks" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("K", "♣︎"),
          PokerCerberina::Card.new("K", "♥︎"),
          PokerCerberina::Card.new("10", "♥︎"),
          PokerCerberina::Card.new("10", "♠︎"),
          PokerCerberina::Card.new("10", "♣︎"),
        ])
      end
      let(:expected_combination) do
        [PokerCerberina::Combination.new("full_house",
                                         [PokerCerberina::Card.new("K", "♠︎"),
                                          PokerCerberina::Card.new("10", "♠︎"),
                                          PokerCerberina::Card.new("K", "♣︎"),
                                          PokerCerberina::Card.new("K", "♥︎"),
                                          PokerCerberina::Card.new("10", "♥︎")])]
      end
      it "finds the full_house" do
        expect(find_full_house).to eq(expected_combination)
      end
    end
    context "when hand doesn't contain 1 pair of cards with same ranks and set of 3 cards with same ranks" do
      let (:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("3", "♠︎"),
          PokerCerberina::Card.new("K", "♣︎"),
          PokerCerberina::Card.new("K", "♥︎"),
          PokerCerberina::Card.new("2", "♣︎"),
        ])
      end
      it "doesn't find the full_house" do
        expect(find_full_house).to eq([])
      end
    end
  end
  describe "find_flush" do
    subject (:find_flush) { search.find_flush }
    context "when all cards in hand have the same suit" do
      let (:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("2", "♠︎"),
          PokerCerberina::Card.new("3", "♠︎"),
          PokerCerberina::Card.new("Q", "♠︎"),
          PokerCerberina::Card.new("A", "♠︎"),
        ])
      end
      let(:expected_combination) do
        [PokerCerberina::Combination.new("flush",
                                         [PokerCerberina::Card.new("K", "♠︎"),
                                          PokerCerberina::Card.new("3", "♠︎"),
                                          PokerCerberina::Card.new("2", "♠︎"),
                                          PokerCerberina::Card.new("A", "♠︎"),
                                          PokerCerberina::Card.new("Q", "♠︎")])]
      end
      it "finds the flush" do
        expect(find_flush).to eq(expected_combination)
      end
    end
    context "when all cards in hand have the same suit" do
      let (:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("2", "♠︎"),
          PokerCerberina::Card.new("7", "♠︎"),
          PokerCerberina::Card.new("Q", "♠︎"),
          PokerCerberina::Card.new("J", "♠︎"),
          PokerCerberina::Card.new("7", "♠︎"),
          PokerCerberina::Card.new("3", "♠︎"),
        ])
      end
      let(:expected_combination) do
        [PokerCerberina::Combination.new("flush",
                                         [PokerCerberina::Card.new("K", "♠︎"),
                                          PokerCerberina::Card.new("J", "♠︎"),
                                          PokerCerberina::Card.new("7", "♠︎"),
                                          PokerCerberina::Card.new("9", "♠︎"),
                                          PokerCerberina::Card.new("Q", "♠︎")])]
      end
      it "finds the highest flush" do
        expect(find_flush).to eq(expected_combination)
      end
    end
    context "hand contains cards with different suits" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("2", "♠︎"),
          PokerCerberina::Card.new("3", "♠︎"),
          PokerCerberina::Card.new("Q", "♠︎"),
          PokerCerberina::Card.new("A", "♥︎"),
        ])
      end
      it "doesn't find the flush" do
        expect(find_flush).to eq([])
      end
    end
  end
  describe "find_straight" do
    subject (:find_straight) { search.find_straight }
    context "when hand contains sequense of 5 cards by ranks" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("J", "♦︎"),
          PokerCerberina::Card.new("10", "♣︎"),
          PokerCerberina::Card.new("Q", "♠︎"),
          PokerCerberina::Card.new("A", "♥︎"),
        ])
      end
      let(:expected_combination) do
        [PokerCerberina::Combination.new("straight",
                                         [PokerCerberina::Card.new("K", "♠︎"),
                                          PokerCerberina::Card.new("J", "♦︎"),
                                          PokerCerberina::Card.new("10", "♣︎"),
                                          PokerCerberina::Card.new("A", "♥︎"),
                                          PokerCerberina::Card.new("Q", "♠︎")])]
      end
      it "finds the straight" do
        expect(find_straight).to eq(expected_combination)
      end
    end
    context "when hand contains 3 sequense of 5 cards by ranks" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("J", "♦︎"),
          PokerCerberina::Card.new("10", "♣︎"),
          PokerCerberina::Card.new("Q", "♠︎"),
          PokerCerberina::Card.new("9", "♥︎"),
          PokerCerberina::Card.new("8", "♦︎"),
          PokerCerberina::Card.new("7", "♥︎"),
        ])
      end
      let(:expected_combination) do
        [PokerCerberina::Combination.new("straight",
                                         [PokerCerberina::Card.new("K", "♠︎"),
                                          PokerCerberina::Card.new("J", "♦︎"),
                                          PokerCerberina::Card.new("10", "♣︎"),
                                          PokerCerberina::Card.new("9", "♥︎"),
                                          PokerCerberina::Card.new("Q", "♠︎")])]
      end
      it "finds the highest straight" do
        expect(find_straight).to eq(expected_combination)
      end
    end
    context "when hand doesn't contain sequense of 5 cards by ranks" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♠︎"),
          PokerCerberina::Card.new("2", "♠︎"),
          PokerCerberina::Card.new("3", "♠︎"),
          PokerCerberina::Card.new("Q", "♠︎"),
          PokerCerberina::Card.new("A", "♥︎"),
        ])
      end
      it "doesn't find the straight" do
        expect(find_straight).to eq([])
      end
    end
  end
  describe "find_straight_flush" do
    subject (:find_straight_flush) { search.find_straight_flush }
    context "when hand contains sequense of 5 cards by ranks and all these cards have same suit" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♦︎"),
          PokerCerberina::Card.new("J", "♦︎"),
          PokerCerberina::Card.new("10", "♦︎"),
          PokerCerberina::Card.new("Q", "♦︎"),
          PokerCerberina::Card.new("A", "♦︎"),
        ])
      end
      let(:expected_combination) do
        [PokerCerberina::Combination.new("straight_flush",
                                         [PokerCerberina::Card.new("K", "♦︎"),
                                          PokerCerberina::Card.new("J", "♦︎"),
                                          PokerCerberina::Card.new("10", "♦︎"),
                                          PokerCerberina::Card.new("A", "♦︎"),
                                          PokerCerberina::Card.new("Q", "♦︎")])]
      end
      it "finds the straight flush" do
        expect(find_straight_flush).to eq(expected_combination)
      end
    end
    context "when hand contains 3 sequense of 5 cards by ranks with the same suit" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♣︎"),
          PokerCerberina::Card.new("J", "♣︎"),
          PokerCerberina::Card.new("10", "♣︎"),
          PokerCerberina::Card.new("Q", "♣︎"),
          PokerCerberina::Card.new("9", "♣︎"),
          PokerCerberina::Card.new("8", "♣︎"),
          PokerCerberina::Card.new("7", "♣︎"),
        ])
      end
      let(:expected_combination) do
        [PokerCerberina::Combination.new("straight",
                                         [PokerCerberina::Card.new("K", "♣︎"),
                                          PokerCerberina::Card.new("J", "♣︎"),
                                          PokerCerberina::Card.new("10", "♣︎"),
                                          PokerCerberina::Card.new("9", "♣︎"),
                                          PokerCerberina::Card.new("Q", "♣︎")])]
      end
      it "finds the highest straight" do
        expect(find_straight_flush).to eq(expected_combination)
      end
    end
    context "when hand contains sequense of 5 cards by ranks but not and all these cards have same suit" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♦︎"),
          PokerCerberina::Card.new("J", "♦︎"),
          PokerCerberina::Card.new("10", "♥︎"),
          PokerCerberina::Card.new("Q", "♦︎"),
          PokerCerberina::Card.new("A", "♦︎"),
        ])
      end
      it "doesn't find the straight flush" do
        expect(find_straight_flush).to eq([])
      end
    end
  end
  describe "find_royal_flush" do
    subject (:find_royal_flush) { search.find_royal_flush }
    context "when hand contains sequense of 5 cards by ranks(the highest is A) and all these cards have same suit" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♦︎"),
          PokerCerberina::Card.new("J", "♦︎"),
          PokerCerberina::Card.new("10", "♦︎"),
          PokerCerberina::Card.new("Q", "♦︎"),
          PokerCerberina::Card.new("A", "♦︎"),
        ])
      end
      let(:expected_combination) do
        [PokerCerberina::Combination.new("royal_flush",
                                         [PokerCerberina::Card.new("K", "♦︎"),
                                          PokerCerberina::Card.new("J", "♦︎"),
                                          PokerCerberina::Card.new("10", "♦︎"),
                                          PokerCerberina::Card.new("A", "♦︎"),
                                          PokerCerberina::Card.new("Q", "♦︎")])]
      end
      it "finds the royal_flush" do
        expect(find_royal_flush).to eq(expected_combination)
      end
    end
    context "when hand contains sequense of 5 cards by ranks but not and all these cards have same suit" do
      let(:hand) do
        PokerCerberina::Hand.new([
          PokerCerberina::Card.new("K", "♦︎"),
          PokerCerberina::Card.new("J", "♦︎"),
          PokerCerberina::Card.new("10", "♥︎"),
          PokerCerberina::Card.new("Q", "♦︎"),
          PokerCerberina::Card.new("A", "♦︎"),
        ])
      end
      it "doesn't find the royal_flush" do
        expect(find_royal_flush).to eq([])
      end
    end
  end
end
