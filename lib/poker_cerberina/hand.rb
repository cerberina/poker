class PokerCerberina::Hand
  include Enumerable
  attr_reader :cards

  def initialize(cards)
    @cards = cards
    #for a in 1..number
    #  @hand << PokerCerberina::Deck.new.shuffle.select_card
    #end
  end

  def each
    cards.each do |card|
      yield card
    end
  end

  def group_rank
    groups = {}
    cards.each do |c|
      if groups[c.rank]
        groups[c.rank] << c
      else
        groups[c.rank] = [c]
      end
    end
    groups
  end

  def group_suit
    groups = {}
    cards.each do |c|
      if groups[c.suit]
        groups[c.suit] << c
      else
        groups[c.suit] = [c]
      end
    end
    groups
  end
end
