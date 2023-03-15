module PokerCerberina
  SUIT = ["♠︎", "♣︎", "♥︎", "♦︎"]
  RANK = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
end

class PokerCerberina::Deck
  def initialize
    @deck = []
    PokerCerberina::SUIT.each do |s|
      PokerCerberina::RANK.each do |r|
        @deck << PokerCerberina::Card.new(r, s)
      end
    end
  end

  def size
    @deck.size
  end

  def print_deck
    @deck.each { |d| puts d.print_card }
  end

  def shuffle
    @deck.shuffle!
  end
end

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

  def print_card
    puts "#{@rank}#{@suit}"
  end
end

def find_pairs(cards)
  groups = {}
  hand.each do |c|
    if groups[c.rank]
      groups[c.rank] << c
    else
      groups[c.rank] = [c]
    end
  end
  result = false
  groups.each_value do |value|
    if value.size == 2
      value.each { |v| v.print_card }
    end
  end
  result
end

def search_combinations
  hand = PokerCerberina::Deck.new.shuffle[0..4]
  #hand = [PokerCerberina::Card.new("K", "♠︎"), PokerCerberina::Card.new("K", "♣︎"), PokerCerberina::Card.new("K", "♥︎"), PokerCerberina::Card.new("2", "♠︎"), PokerCerberina::Card.new("2", "♣︎")]
  groups = {}
  hand.each do |c|
    if groups[c.rank]
      groups[c.rank] << c
    else
      groups[c.rank] = [c]
    end
  end
  groups.each_value do |value|
    if value.size == 2
      puts "__________________________________"
      puts "It's a pair!"
      value.each { |v| v.print_card }
    elsif value.size == 3
      puts "__________________________________"
      puts "It's a set!"
      value.each { |v| v.print_card }
    elsif value.size == 4
      puts "__________________________________"
      puts "It's a quads!"
      value.each { |v| v.print_card }
    end
  end
end
