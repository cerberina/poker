class PokerCerberina::Hand
  include Enumerable
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def each
    cards.each do |card|
      yield card
    end
  end
end
