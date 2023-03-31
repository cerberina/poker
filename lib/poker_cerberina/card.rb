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

  def to_s
    "#{rank}#{suit}"
  end

  def straight_down
    # if rank of card less than 6 - there no straight
    if PokerCerberina::RANK.index(rank) <= 3
      return []
    else
      PokerCerberina::RANK[PokerCerberina::RANK.index(rank) - 4..PokerCerberina::RANK.index(rank)]
    end
  end
end
