class PokerCerberina::CombinationSearch
  attr_reader :hand

  def initialize(hand)
    @hand = hand
  end

  def find_kiker
    result = []
    #(hand - cards of combinations).max
    result << PokerCerberina::Combination.new("kiker", hand.max)
  end

  def find_pairs
    result = []
    pair = groups_of_size(2).last
    result << PokerCerberina::Combination.new("pair", pair) if pair
    result
  end

  def find_two_pairs
    result = []
    two_pairs = groups_of_size(2).last(2).flatten!
    result << PokerCerberina::Combination.new("two_pairs", two_pairs) if two_pairs && two_pairs.count == 4
    result
  end

  def find_sets
    result = []
    set = groups_of_size(3).sort_by(&:first).last
    result << PokerCerberina::Combination.new("set", set) if set
    result
  end

  def find_quads
    result = []
    quad = groups_of_size(4).sort_by(&:first).last
    result << PokerCerberina::Combination.new("quad", quad) if quad
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
    pair << set.sort.shift.first(2) if set.count >= 2
    pair = pair.max if pair.count >= 2
    if !pair.empty? && !set.empty?
      result << PokerCerberina::Combination.new("full_house", (pair + set.max).flatten)
    end
    result
  end

  def find_flush
    result = []
    array_of_cards = []
    group_suit.each_value do |value|
      if value.size >= 5
        array_of_cards << value
      end
    end
    result << PokerCerberina::Combination.new("flush", array_of_cards.flatten.sort.last(5)) unless array_of_cards.empty?
    result
  end

  def find_straight
    result = []
    result << PokerCerberina::Combination.new("straight", highest_5_card) unless highest_5_card.empty?
    result
  end

  def find_straight_flush
    result = []
    buffer = highest_5_card
    unless buffer.empty?
      f_card_suit = buffer.first.suit
      buffer.each do |card|
        unless card.suit == f_card_suit
          buffer = []
        end
      end
      result << PokerCerberina::Combination.new("straight_flush", buffer) unless buffer.empty?
    end
    result
  end

  def find_royal_flush
    result = []
    buffer = highest_5_card
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

  def groups_of_size(size)
    array_of_cards = []
    group_rank.each_value do |value|
      if value.size == size
        array_of_cards << value
      end
    end
    array_of_cards.sort_by(&:first)
  end

  def highest_5_card
    array_of_cards = []
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
        unless array_of_cards.empty?
          array_of_cards.push(buffer - array_of_cards)
        else
          array_of_cards.push(buffer)
        end
        array_of_cards.flatten!
      end
    end
    array_of_cards.max(5)
  end
end
