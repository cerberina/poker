class PokerCerberina::Combination
  include Comparable
  attr_reader :type, :cards

  def initialize(type, cards)
    @type = type
    @cards = cards
  end

  def ==(other)
    return false if type != other.type
    cards - other.cards == []
  end

  def <=>(other)
    if type == other.type
      compare_equal_types(other)
    elsif type != other.type
      PokerCerberina::HIERARCHY.index(type) <=> PokerCerberina::HIERARCHY.index(other.type)
    end
  end

  def print
    printed_cards = cards.map { |card| card.print }
    "type: #{type}, cards: #{printed_cards.join(",")}"
  end
end

private

def compare_equal_types(other)
  if ["pair", "set", "quad"].include? type
    cards.first.rank <=> other.cards.first.rank
  elsif ["royal_flush", "straight_flush", "straight"].include? type
    cards.sort.last <=> other.cards.sort.last
  elsif ["flush", "kiker"].include? type
    compare_two_arrays(cards, other.cards)
  elsif type == "full_house"
    self_set_rank = rank_of_group(cards, 3).first
    other_set_rank = rank_of_group(other.cards, 3).first
    set_compare = PokerCerberina::RANK.index(self_set_rank) <=> PokerCerberina::RANK.index(other_set_rank)
    return set_compare if set_compare != 0
    self_pair_rank = rank_of_group(cards, 2).first
    other_pair_rank = rank_of_group(other.cards, 2).first
    self_pair_rank <=> other_pair_rank
  elsif type == "two_pairs"
    self_top_pair_rank = rank_of_group(cards, 2).sort.last
    other_top_pair_rank = rank_of_group(other.cards, 2).sort.last
    pairs_compare = PokerCerberina::RANK.index(self_top_pair_rank) <=> PokerCerberina::RANK.index(other_top_pair_rank)
    return pairs_compare if pairs_compare != 0
    self_last_pair_rank = rank_of_group(cards, 2).sort.first
    other_last_pair_rank = rank_of_group(other.cards, 2).sort.first
    PokerCerberina::RANK.index(self_last_pair_rank) <=> PokerCerberina::RANK.index(other_last_pair_rank)
  end
end

def group_rank(cards)
  groups = {}
  cards.each do |c|
    if groups[c.rank]
      groups[c.rank] << c
    else
      groups[c.rank] = [c]
    end
  end
  groups
end

def rank_of_group(cards, size)
  cards_rank = []
  group_rank(cards).each_value do |value|
    if value.size == size
      cards_rank << value[0].rank
    end
  end
  cards_rank
end

def compare_two_arrays(array1, array2)
  compare_result = 0
  sorted_cards = array1.sort.reverse
  sorted_cards2 = array2.sort.reverse
  sorted_cards.each.with_index do |card, index|
    compare_result = PokerCerberina::RANK.index(card.rank) <=> PokerCerberina::RANK.index(sorted_cards2[index].rank)
    return compare_result if compare_result != 0
  end
  return compare_result
end
