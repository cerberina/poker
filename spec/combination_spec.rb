require "rspec"
require "poker_cerberina"

def card(rank, suit)
  PokerCerberina::Card.new(rank, suit)
end

def pair(cards)
  PokerCerberina::Combination.new("pair", cards)
end

describe PokerCerberina::Combination do
  describe "#<=>" do
    describe "compare pair with different combinations" do
      let(:pair_a) do
        pair([card("Q", "♠︎"), card("Q", "♣︎")])
      end
      context "compare two pairs" do
        it "is equal for pairs with same rank" do
          pair_b = PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎")])
          expect(pair_b <=> pair_a).to eq 0
        end
        it "returns false" do
          pair_b = PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎")])
          expect(pair_a < pair_b).to eq false
        end
        it "return true" do
          pair_b = PokerCerberina::Combination.new("pair", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎")])
          expect(pair_a > pair_b).to eq true
        end
      end
      context "compare pair with other type of combination" do
        it "is true that two_pairs are higher than pair" do
          two_pairs = PokerCerberina::Combination.new("two_pairs", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎"),
                                                                    PokerCerberina::Card.new("3", "♦︎"), PokerCerberina::Card.new("3", "♥︎")])
          expect(pair_a < two_pairs).to eq true
        end
        it "is true that pair is higher than kiker" do
          kiker = PokerCerberina::Combination.new("kiker", [PokerCerberina::Card.new("A", "♦︎")])
          expect(pair_a > kiker).to eq true
        end
      end
    end
    describe "compare two_pairs with different combinations" do
      let(:two_pairs_a) do
        PokerCerberina::Combination.new("two_pairs",
                                        [PokerCerberina::Card.new("K", "♠︎"),
                                         PokerCerberina::Card.new("K", "♥︎"),
                                         PokerCerberina::Card.new("2", "♣︎"),
                                         PokerCerberina::Card.new("2", "♠︎")])
      end
      context "compare two_pairs with other type of combination" do
        it "is false that flush is higher than two_pairs" do
          flush = PokerCerberina::Combination.new("flush",
                                                  [PokerCerberina::Card.new("K", "♠︎"),
                                                   PokerCerberina::Card.new("3", "♠︎"),
                                                   PokerCerberina::Card.new("2", "♠︎"),
                                                   PokerCerberina::Card.new("A", "♠︎"),
                                                   PokerCerberina::Card.new("Q", "♠︎")])
          expect(two_pairs_a > flush).to eq false
        end
      end
      context "compare 2 two_pairs" do
        context "higest pair in both two_pair combinations have same rank" do
          it "is equal for 2 two_pairs with the same ranks" do
            two_pairs_b = PokerCerberina::Combination.new("two_pairs",
                                                          [PokerCerberina::Card.new("K", "♦︎"),
                                                           PokerCerberina::Card.new("K", "♣︎"),
                                                           PokerCerberina::Card.new("2", "♥︎"),
                                                           PokerCerberina::Card.new("2", "♦︎")])
            expect(two_pairs_a <=> two_pairs_b).to eq 0
          end
          it "is true that two_pairs where second pair is higher - higher" do
            two_pairs_b = PokerCerberina::Combination.new("two_pairs",
                                                          [PokerCerberina::Card.new("K", "♠︎"),
                                                           PokerCerberina::Card.new("K", "♣︎"),
                                                           PokerCerberina::Card.new("J", "♥︎"),
                                                           PokerCerberina::Card.new("J", "♣︎")])
            expect(two_pairs_a <=> two_pairs_b).to eq -1
          end
        end
        it "is true that two_pairs, where the highest pair is higher than the highest pair in the other combination of two_pairs - higher" do
          two_pairs_b = PokerCerberina::Combination.new("two_pairs",
                                                        [PokerCerberina::Card.new("A", "♦︎"),
                                                         PokerCerberina::Card.new("A", "♣︎"),
                                                         PokerCerberina::Card.new("2", "♥︎"),
                                                         PokerCerberina::Card.new("2", "♦︎")])
          expect(two_pairs_a < two_pairs_b).to eq true
        end
      end
    end
    describe "compare set with different combinations" do
      let(:set_a) do
        PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎"), PokerCerberina::Card.new("J", "♠︎")])
      end
      context "compare two sets" do
        it "is equal for sets with same rank" do
          set_b = PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♣︎"), PokerCerberina::Card.new("J", "♠︎")])
          expect(set_a <=> set_b).to eq 0
        end
        it "should returns false" do
          set_b = PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎"), PokerCerberina::Card.new("Q", "♠︎")])
          expect(set_b < set_a).to eq false
        end
        it "should return true" do
          set_b = PokerCerberina::Combination.new("set", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎"), PokerCerberina::Card.new("Q", "♠︎")])
          expect(set_b > set_a).to eq true
        end
      end
      context "compare set with other type of combination" do
        it "is true that quad is higher than set" do
          quad = PokerCerberina::Combination.new("quad",
                                                 [PokerCerberina::Card.new("K", "♠︎"),
                                                  PokerCerberina::Card.new("K", "♣︎"),
                                                  PokerCerberina::Card.new("K", "♥︎"),
                                                  PokerCerberina::Card.new("K", "♦︎")])
          expect(set_a < quad).to eq true
        end
      end
    end
    describe "compare straight with different combinations" do
      let(:straight_a) do
        PokerCerberina::Combination.new("straight",
                                        [PokerCerberina::Card.new("K", "♠︎"),
                                         PokerCerberina::Card.new("J", "♦︎"),
                                         PokerCerberina::Card.new("10", "♣︎"),
                                         PokerCerberina::Card.new("9", "♥︎"),
                                         PokerCerberina::Card.new("Q", "♠︎")])
      end
      context "two straights" do
        it "is equal for straights with same rank" do
          straight_b = PokerCerberina::Combination.new("straight",
                                                       [PokerCerberina::Card.new("J", "♠︎"),
                                                        PokerCerberina::Card.new("10", "♠︎"),
                                                        PokerCerberina::Card.new("9", "♣︎"),
                                                        PokerCerberina::Card.new("K", "♦︎"),
                                                        PokerCerberina::Card.new("Q", "♥︎")])
          expect(straight_a <=> straight_b).to eq 0
        end
        it "is true that than higher cards in straight - than higher straight" do
          straight_b = PokerCerberina::Combination.new("straight",
                                                       [PokerCerberina::Card.new("J", "♠︎"),
                                                        PokerCerberina::Card.new("10", "♠︎"),
                                                        PokerCerberina::Card.new("9", "♣︎"),
                                                        PokerCerberina::Card.new("8", "♦︎"),
                                                        PokerCerberina::Card.new("Q", "♥︎")])
          expect(straight_a <=> straight_b).to eq 1
        end
      end
      context "straight with other type of combination" do
        it "is true that full_house is higher than straight" do
          full_house = PokerCerberina::Combination.new("full_house",
                                                       [PokerCerberina::Card.new("K", "♠︎"),
                                                        PokerCerberina::Card.new("10", "♠︎"),
                                                        PokerCerberina::Card.new("K", "♣︎"),
                                                        PokerCerberina::Card.new("K", "♥︎"),
                                                        PokerCerberina::Card.new("10", "♣︎")])
          expect(straight_a < full_house).to eq true
        end
      end
    end
    describe "compare flush with different combinations" do
      let(:flush_a) do
        PokerCerberina::Combination.new("flush",
                                        [PokerCerberina::Card.new("K", "♠︎"),
                                         PokerCerberina::Card.new("3", "♠︎"),
                                         PokerCerberina::Card.new("2", "♠︎"),
                                         PokerCerberina::Card.new("A", "♠︎"),
                                         PokerCerberina::Card.new("Q", "♠︎")])
      end
      context "two flushes" do
        it "is equal for flushes with same ranks" do
          flush_b = PokerCerberina::Combination.new("flush",
                                                    [PokerCerberina::Card.new("K", "♦︎"),
                                                     PokerCerberina::Card.new("3", "♦︎"),
                                                     PokerCerberina::Card.new("2", "♦︎"),
                                                     PokerCerberina::Card.new("A", "♦︎"),
                                                     PokerCerberina::Card.new("Q", "♦︎")])
          expect(flush_a <=> flush_b).to eq 0
        end
        it "is true that than higher cards in flush - than higher flush" do
          flush_b = PokerCerberina::Combination.new("flush",
                                                    [PokerCerberina::Card.new("K", "♦︎"),
                                                     PokerCerberina::Card.new("5", "♦︎"),
                                                     PokerCerberina::Card.new("4", "♦︎"),
                                                     PokerCerberina::Card.new("A", "♦︎"),
                                                     PokerCerberina::Card.new("Q", "♦︎")])
          expect(flush_a < flush_b).to eq true
        end
      end
      context "flush with other type of combination" do
        it "is true that straight_flush is higher than flush" do
          straight_flush = PokerCerberina::Combination.new("straight_flush",
                                                           [PokerCerberina::Card.new("8", "♦︎"),
                                                            PokerCerberina::Card.new("J", "♦︎"),
                                                            PokerCerberina::Card.new("10", "♦︎"),
                                                            PokerCerberina::Card.new("9", "♦︎"),
                                                            PokerCerberina::Card.new("7", "♦︎")])
          expect(flush_a < straight_flush).to eq true
        end
      end
    end
    describe "compare full_house with different combinations" do
      let(:full_house_a) do
        PokerCerberina::Combination.new("full_house",
                                        [PokerCerberina::Card.new("K", "♦︎"),
                                         PokerCerberina::Card.new("10", "♥︎"),
                                         PokerCerberina::Card.new("K", "♣︎"),
                                         PokerCerberina::Card.new("K", "♥︎"),
                                         PokerCerberina::Card.new("10", "♦︎")])
      end
      context "two full_houses" do
        it "is equal for full_houses with same ranks" do
          full_house_b = PokerCerberina::Combination.new("full_house",
                                                         [PokerCerberina::Card.new("K", "♠︎"),
                                                          PokerCerberina::Card.new("10", "♠︎"),
                                                          PokerCerberina::Card.new("K", "♣︎"),
                                                          PokerCerberina::Card.new("K", "♥︎"),
                                                          PokerCerberina::Card.new("10", "♣︎")])
          expect(full_house_a <=> full_house_b).to eq 0
        end
        it "is true that full_house is higher if its set is higher" do
          full_house_b = PokerCerberina::Combination.new("full_house",
                                                         [PokerCerberina::Card.new("J", "♠︎"),
                                                          PokerCerberina::Card.new("10", "♠︎"),
                                                          PokerCerberina::Card.new("J", "♣︎"),
                                                          PokerCerberina::Card.new("J", "♥︎"),
                                                          PokerCerberina::Card.new("10", "♣︎")])
          expect(full_house_a > full_house_b).to eq true
        end
        it "is true that if 3 cards have the same ranks in 2 full_houses, then that full_house is higher what contain higher pair" do
          full_house_b = PokerCerberina::Combination.new("full_house",
                                                         [PokerCerberina::Card.new("K", "♠︎"),
                                                          PokerCerberina::Card.new("Q", "♠︎"),
                                                          PokerCerberina::Card.new("K", "♣︎"),
                                                          PokerCerberina::Card.new("K", "♥︎"),
                                                          PokerCerberina::Card.new("Q", "♣︎")])
          expect(full_house_a < full_house_b).to eq true
        end
      end
      context "full_house with other type of combination" do
        it "is true that full_house is higher than pair" do
          pair = PokerCerberina::Combination.new("pair",
                                                 [PokerCerberina::Card.new("2", "♠︎"),
                                                  PokerCerberina::Card.new("2", "♣︎")])
          expect(full_house_a > pair).to eq true
        end
      end
    end
    describe "compare quad with different combinations" do
      let (:quad_a) do
        PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♥︎"), PokerCerberina::Card.new("J", "♠︎"), PokerCerberina::Card.new("J", "♣︎")])
      end
      context "compare quad with other type of combination" do
        it "is false that full_house is higher than quad" do
          full_house = PokerCerberina::Combination.new("full_house",
                                                       [PokerCerberina::Card.new("K", "♠︎"),
                                                        PokerCerberina::Card.new("10", "♠︎"),
                                                        PokerCerberina::Card.new("K", "♣︎"),
                                                        PokerCerberina::Card.new("K", "♥︎"),
                                                        PokerCerberina::Card.new("10", "♣︎")])
          expect(quad_a < full_house).to eq false
        end
      end
      context "compare two quads" do
        it "is equal for quads with same rank" do
          quad_b = PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("J", "♦︎"), PokerCerberina::Card.new("J", "♣︎"), PokerCerberina::Card.new("J", "♠︎"), PokerCerberina::Card.new("J", "♥︎")])
          expect(quad_a <=> quad_b).to eq 0
        end
        it "should returns false" do
          quad_b = PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎"), PokerCerberina::Card.new("Q", "♠︎"), PokerCerberina::Card.new("Q", "♣︎")])
          expect(quad_b < quad_a).to eq false
        end
        it "should return true" do
          quad_b = PokerCerberina::Combination.new("quad", [PokerCerberina::Card.new("Q", "♦︎"), PokerCerberina::Card.new("Q", "♥︎"), PokerCerberina::Card.new("Q", "♠︎"), PokerCerberina::Card.new("Q", "♣︎")])
          expect(quad_b > quad_a).to eq true
        end
      end
    end
    describe "compare straight_flush with different combinations" do
      let(:straight_flush_a) do
        PokerCerberina::Combination.new("straight_flush",
                                        [PokerCerberina::Card.new("K", "♣︎"),
                                         PokerCerberina::Card.new("J", "♣︎"),
                                         PokerCerberina::Card.new("10", "♣︎"),
                                         PokerCerberina::Card.new("9", "♣︎"),
                                         PokerCerberina::Card.new("Q", "♣︎")])
      end
      context "compare two straight_flush" do
        it "is equal for straight_flush with same ranks" do
          straight_flush_b = PokerCerberina::Combination.new("straight_flush",
                                                             [PokerCerberina::Card.new("K", "♦︎"),
                                                              PokerCerberina::Card.new("J", "♦︎"),
                                                              PokerCerberina::Card.new("10", "♦︎"),
                                                              PokerCerberina::Card.new("9", "♦︎"),
                                                              PokerCerberina::Card.new("Q", "♦︎")])
          expect(straight_flush_b <=> straight_flush_a).to eq 0
        end
        it "is true that than higher cards in straight_flush - than higher straight_flush" do
          straight_flush_b = PokerCerberina::Combination.new("straight_flush",
                                                             [PokerCerberina::Card.new("8", "♦︎"),
                                                              PokerCerberina::Card.new("J", "♦︎"),
                                                              PokerCerberina::Card.new("10", "♦︎"),
                                                              PokerCerberina::Card.new("9", "♦︎"),
                                                              PokerCerberina::Card.new("Q", "♦︎")])
          expect(straight_flush_b < straight_flush_a).to eq true
        end
      end
      context "compare straight_flush with other type of combination" do
        it "is true that straight_flush higher than two_pairs" do
          two_pairs = PokerCerberina::Combination.new("two_pairs",
                                                      [PokerCerberina::Card.new("K", "♠︎"),
                                                       PokerCerberina::Card.new("K", "♥︎"),
                                                       PokerCerberina::Card.new("2", "♣︎"),
                                                       PokerCerberina::Card.new("2", "♠︎")])
          expect(straight_flush_a > two_pairs).to eq true
        end
      end
    end
    describe "compare royal_flush with different combinations" do
      let(:royal_flush_a) do
        PokerCerberina::Combination.new("royal_flush",
                                        [PokerCerberina::Card.new("K", "♦︎"),
                                         PokerCerberina::Card.new("J", "♦︎"),
                                         PokerCerberina::Card.new("10", "♦︎"),
                                         PokerCerberina::Card.new("A", "♦︎"),
                                         PokerCerberina::Card.new("Q", "♦︎")])
      end
      context "compare two royal_flushes" do
        it "is true that 2 royal_flushes are equal" do
          royal_flush_b = PokerCerberina::Combination.new("royal_flush",
                                                          [PokerCerberina::Card.new("K", "♦︎"),
                                                           PokerCerberina::Card.new("J", "♦︎"),
                                                           PokerCerberina::Card.new("10", "♦︎"),
                                                           PokerCerberina::Card.new("A", "♦︎"),
                                                           PokerCerberina::Card.new("Q", "♦︎")])
          expect(royal_flush_a <=> royal_flush_b).to eq 0
        end
      end
      context "compare royal_flush with other type combination" do
        it "is true that royal_flush is higher than set" do
          set = PokerCerberina::Combination.new("set",
                                                [PokerCerberina::Card.new("A", "♠︎"),
                                                 PokerCerberina::Card.new("A", "♣︎"),
                                                 PokerCerberina::Card.new("A", "♥︎")])
          expect(royal_flush_a > set).to eq true
        end
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
