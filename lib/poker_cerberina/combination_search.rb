class PokerCerberina::CombinationSearch
  attr_reader :hand

  def initialize(hand)
    @hand = hand
  end

  def find_kiker
    result = []
    result << PokerCerberina::Combination.new("kiker", hand.max)
  end

  def find_pairs
    result = []
    hand.group_rank.each_value do |value|
      if value.size == 2
        result << PokerCerberina::Combination.new("pair", value)
      end
    end
    result
  end

  def find_sets
    result = []
    hand.group_rank.each_value do |value|
      if value.size == 3
        result << PokerCerberina::Combination.new("set", value)
      end
    end
    result
  end

  def find_quads
    result = []
    hand.group_rank.each_value do |value|
      if value.size == 4
        result << PokerCerberina::Combination.new("quad", value)
      end
    end
    result
  end

  def find_full_house
    pair = []
    set = []
    result = []
    hand.group_rank.each_value do |value|
      if value.size == 2
        pair << value
      elsif value.size == 3
        set << value
      end
    end
    if !pair.empty? && !set.empty?
      result << PokerCerberina::Combination.new("full_house", (pair + set).flatten)
    end
    result
  end

  def find_flush
    result = []
    hand.group_suit.each_value do |value|
      if value.size == 5
        result << PokerCerberina::Combination.new("flush", value)
      end
    end
    result
  end

  def find_straight
    result = []
    hand.each do |card|
      buffer = []
      teor_ranks = card.straight_down
      teor_ranks.each do |rank|
        if found_card = hand.find_by_rank(rank)
          buffer << found_card
        else
          break
        end
      end
      unless buffer.empty?
        result << PokerCerberina::Combination.new("straight", buffer)
      end
    end
    result
  end

  private

  def group_rank
    groups = {}
    hand.each do |c|
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
    hand.each do |c|
      if groups[c.suit]
        groups[c.suit] << c
      else
        groups[c.suit] = [c]
      end
    end
    groups
  end

  def find_by_rank(rank)
    group_rank[rank]&.first
  end
end
