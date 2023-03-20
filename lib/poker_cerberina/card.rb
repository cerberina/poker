require "poker_cerberina.rb"

class PokerCerberina::Card
  include Comparable
  attr_reader :rank, :suit

  def initialize(rank, suit)
    raise "Invalid value for rank" unless PokerCerberina::RANK.include? rank
    @rank = rank
    raise "Invalid value for suit" unless PokerCerberina::SUIT.include? suit
    @suit = suit
  end

  def <=>(other)
    PokerCerberina::RANK.index(rank) <=> PokerCerberina::RANK.index(other.rank)
  end

  def eql?(other)
    self == other
  end

  def ==(other)
    if rank == other.rank
      if suit == other.suit
        return true
      end
    end
    return false
  end

  def previous_rank
    PokerCerberina::RANK[PokerCerberina::RANK.index(rank) - 1]
  end

  def straight_down(card)
    # if rank of card less than 6 - there no straight
    if card.rank <= ""
    card.rank - 5..card.rank
  end
end
