require "rspec"
require "poker_cerberina"

def card(rank, suit)
  PokerCerberina::Card.new(rank, suit)
end

def kiker(cards)
  PokerCerberina::Combination.new("kiker", cards)
end

def pair(cards)
  PokerCerberina::Combination.new("pair", cards)
end

def two_pairs(cards)
  PokerCerberina::Combination.new("two_pairs", cards)
end

def set(cards)
  PokerCerberina::Combination.new("set", cards)
end

def straight(cards)
  PokerCerberina::Combination.new("straight", cards)
end

def flush(cards)
  PokerCerberina::Combination.new("flush", cards)
end

def full_house(cards)
  PokerCerberina::Combination.new("full_house", cards)
end

def quad(cards)
  PokerCerberina::Combination.new("quad", cards)
end

def straight_flush(cards)
  PokerCerberina::Combination.new("straight_flush", cards)
end

def royal_flush(cards)
  PokerCerberina::Combination.new("royal_flush", cards)
end

describe PokerCerberina::Combination do
  describe "#<=>" do
    describe "compare kiker with different combinations" do
      let(:kiker_a) do
        kiker([card("A", "♠︎"), card("Q", "♣︎")])
      end
      context "compare two kikers" do
        it "is equal for kiker with same ranks" do
          kiker_b = kiker([card("A", "♣︎"), card("Q", "♥︎")])
          expect(kiker_a <=> kiker_b).to eq 0
        end
        it "returns true" do
          kiker_b = kiker([card("K", "♣︎"), card("Q", "♥︎")])
          expect(kiker_a > kiker_b).to eq true
        end
      end
      context "compare kiker with other type of combination" do
        it "is true that straight_flush higher than kiker " do
          straight_flush = straight_flush(
            [card("K", "♣︎"),
             card("J", "♣︎"),
             card("10", "♣︎"),
             card("9", "♣︎"),
             card("Q", "♣︎")]
          )
          expect(straight_flush > kiker_a).to eq true
        end
      end
    end
    describe "compare pair with different combinations" do
      let(:pair_a) do
        pair([card("Q", "♠︎"), card("Q", "♣︎")])
      end
      context "compare two pairs" do
        it "is equal for pairs with same rank" do
          pair_b = pair([card("Q", "♦︎"), card("Q", "♥︎")])
          expect(pair_b <=> pair_a).to eq 0
        end
        it "returns false" do
          pair_b = pair([card("J", "♦︎"), card("J", "♥︎")])
          expect(pair_a < pair_b).to eq false
        end
        it "returns true" do
          pair_b = pair([card("J", "♦︎"), card("J", "♥︎")])
          expect(pair_a > pair_b).to eq true
        end
      end
      context "compare pair with other type of combination" do
        it "is true that two_pairs are higher than pair" do
          two_pairs = two_pairs([card("J", "♦︎"), card("J", "♥︎"),
                                 card("3", "♦︎"), card("3", "♥︎")])
          expect(pair_a < two_pairs).to eq true
        end
        it "is true that pair is higher than kiker" do
          kiker = kiker([card("A", "♦︎")])
          expect(pair_a > kiker).to eq true
        end
      end
    end
    describe "compare two_pairs with different combinations" do
      let(:two_pairs_a) do
        two_pairs(
          [card("K", "♠︎"),
           card("K", "♥︎"),
           card("2", "♣︎"),
           card("2", "♠︎")]
        )
      end
      context "compare two_pairs with other type of combination" do
        it "is false that flush is higher than two_pairs" do
          flush = PokerCerberina::Combination.new("flush",
                                                  [card("K", "♠︎"),
                                                   card("3", "♠︎"),
                                                   card("2", "♠︎"),
                                                   card("A", "♠︎"),
                                                   card("Q", "♠︎")])
          expect(two_pairs_a > flush).to eq false
        end
      end
      context "compare 2 two_pairs" do
        context "higest pair in both two_pair combinations have same rank" do
          it "is equal for 2 two_pairs with the same ranks" do
            two_pairs_b = two_pairs(
              [card("K", "♦︎"),
               card("K", "♣︎"),
               card("2", "♥︎"),
               card("2", "♦︎")]
            )
            expect(two_pairs_a <=> two_pairs_b).to eq 0
          end
          it "is true that two_pairs where second pair is higher - higher" do
            two_pairs_b = two_pairs(
              [card("K", "♠︎"),
               card("K", "♣︎"),
               card("J", "♥︎"),
               card("J", "♣︎")]
            )
            expect(two_pairs_a <=> two_pairs_b).to eq -1
          end
        end
        it "is true that two_pairs, where the highest pair is higher than the highest pair in the other combination of two_pairs - higher" do
          two_pairs_b = two_pairs(
            [card("A", "♦︎"),
             card("A", "♣︎"),
             card("2", "♥︎"),
             card("2", "♦︎")]
          )
          expect(two_pairs_a < two_pairs_b).to eq true
        end
      end
    end
    describe "compare set with different combinations" do
      let(:set_a) do
        set([card("J", "♦︎"), card("J", "♥︎"), card("J", "♠︎")])
      end
      context "compare two sets" do
        it "is equal for sets with same rank" do
          set_b = set([card("J", "♦︎"), card("J", "♣︎"), card("J", "♠︎")])
          expect(set_a <=> set_b).to eq 0
        end
        it "should returns false" do
          set_b = set([card("Q", "♦︎"), card("Q", "♥︎"), card("Q", "♠︎")])
          expect(set_b < set_a).to eq false
        end
        it "should return true" do
          set_b = set([card("Q", "♦︎"), card("Q", "♥︎"), card("Q", "♠︎")])
          expect(set_b > set_a).to eq true
        end
      end
      context "compare set with other type of combination" do
        it "is true that quad is higher than set" do
          quad = quad(
            [card("K", "♠︎"),
             card("K", "♣︎"),
             card("K", "♥︎"),
             card("K", "♦︎")]
          )
          expect(set_a < quad).to eq true
        end
      end
    end
    describe "compare straight with different combinations" do
      let(:straight_a) do
        straight(
          [card("K", "♠︎"),
           card("J", "♦︎"),
           card("10", "♣︎"),
           card("9", "♥︎"),
           card("Q", "♠︎")]
        )
      end
      context "two straights" do
        it "is equal for straights with same rank" do
          straight_b = straight(
            [card("J", "♠︎"),
             card("10", "♠︎"),
             card("9", "♣︎"),
             card("K", "♦︎"),
             card("Q", "♥︎")]
          )
          expect(straight_a <=> straight_b).to eq 0
        end
        it "is true that than higher cards in straight - than higher straight" do
          straight_b = straight(
            [card("J", "♠︎"),
             card("10", "♠︎"),
             card("9", "♣︎"),
             card("8", "♦︎"),
             card("Q", "♥︎")]
          )
          expect(straight_a <=> straight_b).to eq 1
        end
      end
      context "straight with other type of combination" do
        it "is true that full_house is higher than straight" do
          full_house = full_house(
            [card("K", "♠︎"),
             card("10", "♠︎"),
             card("K", "♣︎"),
             card("K", "♥︎"),
             card("10", "♣︎")]
          )
          expect(straight_a < full_house).to eq true
        end
      end
    end
    describe "compare flush with different combinations" do
      let(:flush_a) do
        PokerCerberina::Combination.new("flush",
                                        [card("K", "♠︎"),
                                         card("3", "♠︎"),
                                         card("2", "♠︎"),
                                         card("A", "♠︎"),
                                         card("Q", "♠︎")])
      end
      context "two flushes" do
        it "is equal for flushes with same ranks" do
          flush_b = PokerCerberina::Combination.new("flush",
                                                    [card("K", "♦︎"),
                                                     card("3", "♦︎"),
                                                     card("2", "♦︎"),
                                                     card("A", "♦︎"),
                                                     card("Q", "♦︎")])
          expect(flush_a <=> flush_b).to eq 0
        end
        it "is true that than higher cards in flush - than higher flush" do
          flush_b = PokerCerberina::Combination.new("flush",
                                                    [card("K", "♦︎"),
                                                     card("5", "♦︎"),
                                                     card("4", "♦︎"),
                                                     card("A", "♦︎"),
                                                     card("Q", "♦︎")])
          expect(flush_a < flush_b).to eq true
        end
      end
      context "flush with other type of combination" do
        it "is true that straight_flush is higher than flush" do
          straight_flush = straight_flush(
            [card("8", "♦︎"),
             card("J", "♦︎"),
             card("10", "♦︎"),
             card("9", "♦︎"),
             card("7", "♦︎")]
          )
          expect(flush_a < straight_flush).to eq true
        end
      end
    end
    describe "compare full_house with different combinations" do
      let(:full_house_a) do
        full_house(
          [card("K", "♦︎"),
           card("10", "♥︎"),
           card("K", "♣︎"),
           card("K", "♥︎"),
           card("10", "♦︎")]
        )
      end
      context "two full_houses" do
        it "is equal for full_houses with same ranks" do
          full_house_b = full_house(
            [card("K", "♠︎"),
             card("10", "♠︎"),
             card("K", "♣︎"),
             card("K", "♥︎"),
             card("10", "♣︎")]
          )
          expect(full_house_a <=> full_house_b).to eq 0
        end
        it "is true that full_house is higher if its set is higher" do
          full_house_b = full_house(
            [card("J", "♠︎"),
             card("10", "♠︎"),
             card("J", "♣︎"),
             card("J", "♥︎"),
             card("10", "♣︎")]
          )
          expect(full_house_a > full_house_b).to eq true
        end
        it "is true that if 3 cards have the same ranks in 2 full_houses, then that full_house is higher what contain higher pair" do
          full_house_b = full_house(
            [card("K", "♠︎"),
             card("Q", "♠︎"),
             card("K", "♣︎"),
             card("K", "♥︎"),
             card("Q", "♣︎")]
          )
          expect(full_house_a < full_house_b).to eq true
        end
      end
      context "full_house with other type of combination" do
        it "is true that full_house is higher than pair" do
          pair = pair(
            [card("2", "♠︎"),
             card("2", "♣︎")]
          )
          expect(full_house_a > pair).to eq true
        end
      end
    end
    describe "compare quad with different combinations" do
      let (:quad_a) do
        quad([card("J", "♦︎"), card("J", "♥︎"), card("J", "♠︎"), card("J", "♣︎")])
      end
      context "compare quad with other type of combination" do
        it "is false that full_house is higher than quad" do
          full_house = full_house(
            [card("K", "♠︎"),
             card("10", "♠︎"),
             card("K", "♣︎"),
             card("K", "♥︎"),
             card("10", "♣︎")]
          )
          expect(quad_a < full_house).to eq false
        end
      end
      context "compare two quads" do
        it "is equal for quads with same rank" do
          quad_b = quad([card("J", "♦︎"), card("J", "♣︎"), card("J", "♠︎"), card("J", "♥︎")])
          expect(quad_a <=> quad_b).to eq 0
        end
        it "should returns false" do
          quad_b = quad([card("Q", "♦︎"), card("Q", "♥︎"), card("Q", "♠︎"), card("Q", "♣︎")])
          expect(quad_b < quad_a).to eq false
        end
        it "should return true" do
          quad_b = quad([card("Q", "♦︎"), card("Q", "♥︎"), card("Q", "♠︎"), card("Q", "♣︎")])
          expect(quad_b > quad_a).to eq true
        end
      end
    end
    describe "compare straight_flush with different combinations" do
      let(:straight_flush_a) do
        straight_flush(
          [card("K", "♣︎"),
           card("J", "♣︎"),
           card("10", "♣︎"),
           card("9", "♣︎"),
           card("Q", "♣︎")]
        )
      end
      context "compare two straight_flush" do
        it "is equal for straight_flush with same ranks" do
          straight_flush_b = straight_flush(
            [card("K", "♦︎"),
             card("J", "♦︎"),
             card("10", "♦︎"),
             card("9", "♦︎"),
             card("Q", "♦︎")]
          )
          expect(straight_flush_b <=> straight_flush_a).to eq 0
        end
        it "is true that than higher cards in straight_flush - than higher straight_flush" do
          straight_flush_b = straight_flush(
            [card("8", "♦︎"),
             card("J", "♦︎"),
             card("10", "♦︎"),
             card("9", "♦︎"),
             card("Q", "♦︎")]
          )
          expect(straight_flush_b < straight_flush_a).to eq true
        end
      end
      context "compare straight_flush with other type of combination" do
        it "is true that straight_flush higher than two_pairs" do
          two_pairs = two_pairs(
            [card("K", "♠︎"),
             card("K", "♥︎"),
             card("2", "♣︎"),
             card("2", "♠︎")]
          )
          expect(straight_flush_a > two_pairs).to eq true
        end
      end
    end
    describe "compare royal_flush with different combinations" do
      let(:royal_flush_a) do
        royal_flush(
          [card("K", "♦︎"),
           card("J", "♦︎"),
           card("10", "♦︎"),
           card("A", "♦︎"),
           card("Q", "♦︎")]
        )
      end
      context "compare two royal_flushes" do
        it "is true that 2 royal_flushes are equal" do
          royal_flush_b = royal_flush(
            [card("K", "♦︎"),
             card("J", "♦︎"),
             card("10", "♦︎"),
             card("A", "♦︎"),
             card("Q", "♦︎")]
          )
          expect(royal_flush_a <=> royal_flush_b).to eq 0
        end
      end
      context "compare royal_flush with other type combination" do
        it "is true that royal_flush is higher than set" do
          set = set(
            [card("A", "♠︎"),
             card("A", "♣︎"),
             card("A", "♥︎")]
          )
          expect(royal_flush_a > set).to eq true
        end
      end
    end
  end
  describe "#==" do
    context "when 2 pairs have same suit" do
      it "isn't equal for pairs with different rank" do
        combination_a = pair([card("J", "♦︎"), card("J", "♥︎")])
        combination_b = pair([card("Q", "♦︎"), card("Q", "♥︎")])
        expect(combination_a == combination_b).to eq false
      end
      it "is equal for pairs with same rank" do
        combination_a = pair([card("2", "♠︎"), card("2", "♣︎")])
        combination_b = pair([card("2", "♠︎"), card("2", "♣︎")])
        expect(combination_a == combination_b).to eq true
      end
    end
    context "when 2 two_pairs have same suit" do
      it "isn't equal for pairs with different rank" do
        combination_a = two_pairs([card("J", "♦︎"), card("J", "♥︎"), card("5", "♠︎"), card("5", "♣︎")])
        combination_b = two_pairs([card("Q", "♦︎"), card("Q", "♥︎"), card("7", "♠︎"), card("7", "♣︎")])
        expect(combination_a == combination_b).to eq false
      end
      it "is equal for pairs with same rank" do
        combination_a = two_pairs([card("2", "♠︎"), card("2", "♣︎"), card("8", "♠︎"), card("8", "♣︎")])
        combination_b = two_pairs([card("2", "♠︎"), card("2", "♣︎"), card("8", "♠︎"), card("8", "♣︎")])
        expect(combination_a == combination_b).to eq true
      end
    end
    context "when 2 sets have same suit" do
      it "isn't equal for sets with different rank" do
        combination_a = set([card("J", "♦︎"), card("J", "♥︎"), card("J", "♠︎")])
        combination_b = set([card("Q", "♦︎"), card("Q", "♥︎"), card("Q", "♠︎")])
        expect(combination_a == combination_b).to eq false
      end
      it "is equal for sets with same rank" do
        combination_a = set([card("J", "♦︎"), card("J", "♥︎"), card("J", "♠︎")])
        combination_b = set([card("J", "♦︎"), card("J", "♥︎"), card("J", "♠︎")])
        expect(combination_a == combination_b).to eq true
      end
    end
    context "when 2 straights have same suit" do
      it "isn't equal for straights with different rank" do
        combination_a = straight([card("K", "♠︎"),
                                  card("J", "♦︎"),
                                  card("10", "♣︎"),
                                  card("9", "♥︎"),
                                  card("Q", "♠︎")])
        combination_b = straight([card("Q", "♠︎"),
                                  card("10", "♦︎"),
                                  card("9", "♣︎"),
                                  card("8", "♥︎"),
                                  card("J", "♠︎")])
        expect(combination_a == combination_b).to eq false
      end
      it "is equal for straights with same rank" do
        combination_a = straight([card("K", "♠︎"),
                                  card("J", "♦︎"),
                                  card("10", "♣︎"),
                                  card("9", "♥︎"),
                                  card("Q", "♠︎")])
        combination_b = straight([card("K", "♠︎"),
                                  card("J", "♦︎"),
                                  card("10", "♣︎"),
                                  card("9", "♥︎"),
                                  card("Q", "♠︎")])
        expect(combination_a == combination_b).to eq true
      end
    end
    context "when 2 flushes have same suit" do
      it "isn't equal for flushes with different rank" do
        combination_a = flush([card("2", "♠︎"),
                               card("5", "♠︎"),
                               card("7", "♠︎"),
                               card("9", "♠︎"),
                               card("J", "♠︎")])
        combination_b = flush([card("3", "♠︎"),
                               card("6", "♠︎"),
                               card("8", "♠︎"),
                               card("10", "♠︎"),
                               card("Q", "♠︎")])
        expect(combination_a == combination_b).to eq false
      end
      it "is equal for flushes with same rank" do
        combination_a = flush([card("2", "♠︎"),
                               card("5", "♠︎"),
                               card("7", "♠︎"),
                               card("9", "♠︎"),
                               card("J", "♠︎")])
        combination_b = flush([card("2", "♠︎"),
                               card("5", "♠︎"),
                               card("7", "♠︎"),
                               card("9", "♠︎"),
                               card("J", "♠︎")])
        expect(combination_a == combination_b).to eq true
      end
    end
    context "when 2 full_houses have same suit" do
      it "isn't equal for full_houses with different rank" do
        combination_a = full_house([card("4", "♦︎"),
                                    card("4", "♠︎"),
                                    card("9", "♣︎"),
                                    card("9", "♥︎"),
                                    card("9", "♠︎")])
        combination_b = full_house([card("6", "♦︎"),
                                    card("6", "♠︎"),
                                    card("3", "♣︎"),
                                    card("3", "♥︎"),
                                    card("3", "♠︎")])
        expect(combination_a == combination_b).to eq false
      end
      it "is equal for full_houses with same rank" do
        combination_a = full_house([card("4", "♦︎"),
                                    card("4", "♠︎"),
                                    card("9", "♣︎"),
                                    card("9", "♥︎"),
                                    card("9", "♠︎")])
        combination_b = full_house([card("4", "♦︎"),
                                    card("4", "♠︎"),
                                    card("9", "♣︎"),
                                    card("9", "♥︎"),
                                    card("9", "♠︎")])
        expect(combination_a == combination_b).to eq true
      end
    end
    context "when 2 quads have same suit" do
      it "isn't equal for quads with different rank" do
        combination_a = quad([card("J", "♦︎"), card("J", "♥︎"), card("J", "♠︎"), card("J", "♣︎")])
        combination_b = quad([card("Q", "♦︎"), card("Q", "♥︎"), card("Q", "♠︎"), card("Q", "♣︎")])
        expect(combination_a == combination_b).to eq false
      end
      it "is equal for quads with same rank" do
        combination_a = quad([card("Q", "♦︎"), card("Q", "♥︎"), card("Q", "♠︎"), card("Q", "♣︎")])
        combination_b = quad([card("Q", "♦︎"), card("Q", "♥︎"), card("Q", "♠︎"), card("Q", "♣︎")])
        expect(combination_a == combination_b).to eq true
      end
    end
    context "when 2 straight_flushes have same suit" do
      it "isn't equal for straight_flushes with different rank" do
        combination_a = straight_flush([card("2", "♦︎"),
                                        card("3", "♦︎"),
                                        card("4", "♦︎"),
                                        card("5", "♦︎"),
                                        card("6", "♦︎")])
        combination_b = straight_flush([card("3", "♦︎"),
                                        card("4", "♦︎"),
                                        card("5", "♦︎"),
                                        card("6", "♦︎"),
                                        card("7", "♦︎")])
        expect(combination_a == combination_b).to eq false
      end
      it "is equal for straight_flushes with same rank" do
        combination_a = straight_flush([card("2", "♦︎"),
                                        card("3", "♦︎"),
                                        card("4", "♦︎"),
                                        card("5", "♦︎"),
                                        card("6", "♦︎")])
        combination_b = straight_flush([card("2", "♦︎"),
                                        card("3", "♦︎"),
                                        card("4", "♦︎"),
                                        card("5", "♦︎"),
                                        card("6", "♦︎")])
        expect(combination_a == combination_b).to eq true
      end
    end
    context "when 2 royal_flushes" do
      it "isn't equal for royal_flushes with different suit" do
        combination_a = royal_flush([card("A", "♦︎"),
                                     card("K", "♦︎"),
                                     card("Q", "♦︎"),
                                     card("J", "♦︎"),
                                     card("10", "♦︎")])
        combination_b = royal_flush([card("A", "♣︎"),
                                     card("K", "♣︎"),
                                     card("Q", "♣︎"),
                                     card("J", "♣︎"),
                                     card("10", "♣︎")])
        expect(combination_a == combination_b).to eq false
      end
      it "is equal for royal_flushes with same suit" do
        combination_a = royal_flush([card("A", "♦︎"),
                                     card("K", "♦︎"),
                                     card("Q", "♦︎"),
                                     card("J", "♦︎"),
                                     card("10", "♦︎")])
        combination_b = royal_flush([card("A", "♦︎"),
                                     card("K", "♦︎"),
                                     card("Q", "♦︎"),
                                     card("J", "♦︎"),
                                     card("10", "♦︎")])
        expect(combination_a == combination_b).to eq true
      end
    end
  end
  describe "#print" do
    it "prints card of combination" do
      combination = royal_flush(
        [card("K", "♦︎"),
         card("J", "♦︎"),
         card("10", "♦︎"),
         card("A", "♦︎"),
         card("Q", "♦︎")]
      )
      expect(combination.print).to eq "type: royal_flush, cards: K♦︎,J♦︎,10♦︎,A♦︎,Q♦︎"
    end
    it "prints card of combination" do
      combination = PokerCerberina::Combination.new("kiker", [PokerCerberina::Card.new("A", "♠︎"),
                                                              PokerCerberina::Card.new("3", "♠︎"),
                                                              PokerCerberina::Card.new("K", "♣︎"),
                                                              PokerCerberina::Card.new("Q", "♥︎"),
                                                              PokerCerberina::Card.new("2", "♣︎")])
      expect(combination.print).to eq "type: kiker, cards: A♠︎,3♠︎,K♣︎,Q♥︎,2♣︎"
    end
  end
end
