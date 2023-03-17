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

  def group
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
end
