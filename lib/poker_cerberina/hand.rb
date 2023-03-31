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

  def size
    cards.size
  end

  def to_s
    "#{cards.join(",")}"
  end

  def find_kiker(combination = nil)
    if combination
      PokerCerberina::Combination.new("kiker", hand.cards - combination.cards)
    else
      PokerCerberina::Combination.new("kiker", hand.cards)
    end
  end
end
