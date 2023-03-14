module PokerCerberina
end

class PokerCerberina::Deck
end

class PokerCerberina::Card
  include Comparable
  attr_reader :rank, :suit
  SUIT = ["D", "H", "S", "C"]
  RANK = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

  def initialize(rank, suit)
    raise "Invalid value for rank" unless RANK.include? rank
    @rank = rank
    raise "Invalid value for suit" unless SUIT.include? suit
    @suit = suit
  end

  def <=>(other)
    RANK.index(rank) <=> RANK.index(other.rank)
  end
end
