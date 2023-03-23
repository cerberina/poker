class PokerCerberina::Combination
  include Comparable
  attr_reader :type, :cards

  def initialize(type, cards)
    @type = type
    @cards = cards
  end

  def ==(other)
    if self.type == "kiker"
      self.cards == other.cards
    else
      self.cards - other.cards == []
    end
  end

  def <=>(other)
    if type == other.type
      compare_equal_types(other)
    elsif type != other.type
      PokerCerberina::HIERARCHY.index(type) <=> PokerCerberina::HIERARCHY.index(other.type)
    end
  end
end

private

def compare_equal_types(other)
  if ["pair", "set", "quad"].include? type
    cards.first.rank <=> other.cards.first.rank
  elsif ["royal_flush", "straight_flush", "straight", "flush"].include? type
    cards.sort.last <=> other.cards.sort.last
  elsif type == "full_house"
    self_set_rank = rank_of_group(cards, 3).first
    other_set_rank = rank_of_group(other.cards, 3).first
    set_compare = self_set_rank <=> other_set_rank
    return set_compare if set_compare != 0
    self_pair_rank = rank_of_group(cards, 2).first
    other_pair_rank = rank_of_group(other.cards, 2).first
    self_pair_rank <=> other_pair_rank
  elsif type == "two_pairs"
    self_top_pair_rank = rank_of_group(cards, 2).sort.last
    other_top_pair_rank = rank_of_group(cards, 2).sort.last
    pairs_compare = self_top_pair_rank <=> other_top_pair_rank
    return pairs_compare if pairs_compare != 0
    self_last_pair_rank = rank_of_group(cards, 2).sort.first
    other_last_pair_rank = rank_of_group(cards, 2).sort.first
    self_last_pair_rank <=> other_last_pair_rank
  end

  def group_rank
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
    cards.group_rank.each_value do |value|
      if value.size == size
        cards_rank << value[0].rank
      end
    end
    cards_rank
  end
end
