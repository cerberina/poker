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
    group_rank.each_value do |value|
      if value.size == 2
        result << PokerCerberina::Combination.new("pair", value)
      end
    end
    result
  end

  def find_two_pairs
    result = []
    array_of_pairs = []
    group_rank.each_value do |value|
      if value.size == 2
        array_of_pairs << value
        #result << PokerCerberina::Combination.new("two_pairs", value)
      end
    end
    two_pairs = array_of_pairs.sort_by(&:first).last(2).flatten!
    result << PokerCerberina::Combination.new("two_pairs", two_pairs)
  end

  def find_sets
    result = []
    group_rank.each_value do |value|
      if value.size == 3
        result << PokerCerberina::Combination.new("set", value)
      end
    end
    result.max
  end

  def find_quads
    result = []
    group_rank.each_value do |value|
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
    group_rank.each_value do |value|
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
    group_suit.each_value do |value|
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
        if found_card = find_by_rank(rank)
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

  def find_straight_flush
    result = []
    hand.each do |card|
      buffer = []
      teor_ranks = card.straight_down
      teor_ranks.each do |rank|
        if found_card = find_by_rank(rank)
          buffer << found_card
        else
          break
        end
      end
      unless buffer.empty?
        f_card_suit = buffer.first.suit
        buffer.each do |card|
          unless card.suit == f_card_suit
            buffer = []
          end
        end
        result << PokerCerberina::Combination.new("straight_flush", buffer) unless buffer.empty?
      end
    end
    result
  end

  def find_royal_flush
    result = []
    hand.each do |card|
      buffer = []
      teor_ranks = card.straight_down
      teor_ranks.each do |rank|
        if found_card = find_by_rank(rank)
          buffer << found_card
        else
          break
        end
      end
      unless buffer.empty?
        f_card_suit = buffer.first.suit
        buffer.each do |card|
          unless card.suit == f_card_suit
            buffer = []
          end
        end
        unless buffer.empty?
          if buffer.sort.last.rank == "A"
            result << PokerCerberina::Combination.new("royal_flush", buffer)
          end
        end
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
