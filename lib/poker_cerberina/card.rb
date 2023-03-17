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

  def print_card
    puts "#{@rank}#{@suit}"
  end
end
