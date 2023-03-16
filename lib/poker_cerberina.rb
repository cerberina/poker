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
    self
  end

  def select_card
    @deck.shift
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

class PokerCerberina::Hand
  def initialize(hand)
    @hand = hand
    #for a in 1..number
    #  @hand << PokerCerberina::Deck.new.shuffle.select_card
    #end
  end

  def group
    groups = {}
    @hand.each do |c|
      if groups[c.rank]
        groups[c.rank] << c
      else
        groups[c.rank] = [c]
      end
    end
    groups
  end
end

class PokerCerberina::Combination #(type, cards)
  include Comparable
  # Comparable
  attr_reader :type, :cards

  def initialize(type, cards)
    @type = type
    @cards = cards
  end

  def ==(other)
    self.cards - other.cards == [] && other.cards - self.cards == []
  end

  def <=>(other)
    if type == other.type
      if type == "pair" || "set" || "quad"
        if cards.first.rank < other.cards.first.rank
          return -1
        elsif cards.first.rank == other.cards.first.rank
          return 0
        else
          return 1
        end
        #elsif type == ""
      end
    end
  end
end

class PokerCerberina::CombinationSearch #(hand)
  # search => [Combination, Combination](sorted)
  def find_pairs(hand)
    result = []
    hand.group.each_value do |value|
      if value.size == 2
        result << PokerCerberina::Combination.new("pair", value)
      end
    end
    result
  end

  def find_sets(hand)
    result = []
    hand.group.each_value do |value|
      if value.size == 3
        result << PokerCerberina::Combination.new("set", value)
      end
    end
    result
  end

  def find_quads(hand)
    result = []
    hand.group.each_value do |value|
      if value.size == 4
        result << PokerCerberina::Combination.new("quad", value)
      end
    end
    result
  end

  def find_fullhouse(hand)
    result = []
    pair = []
    hand.group.each_value do |value|
      if value.size == 2
        pair << cards.group[value]
      elsif value.size == 3
        set << cards.group[value]
      end
    end
    if !pair.empty? && !set.empty?
      result << pair
      result << set
    end
    result
  end

=begin
  def search_combinations
    hand = PokerCerberina::Deck.new.shuffle[0..4]
    #hand = [PokerCerberina::Card.new("K", "♠︎"), PokerCerberina::Card.new("K", "♣︎"), PokerCerberina::Card.new("K", "♥︎"), PokerCerberina::Card.new("2", "♠︎"), PokerCerberina::Card.new("2", "♣︎")]
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
=end
end
