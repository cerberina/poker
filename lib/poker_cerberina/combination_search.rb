class PokerCerberina::CombinationSearch
  def find_kiker(hand)
    result = []
    result << PokerCerberina::Combination.new("kiker", hand.max)
  end

  def find_pairs(hand)
    result = []
    hand.group_rank.each_value do |value|
      if value.size == 2
        result << PokerCerberina::Combination.new("pair", value)
      end
    end
    result
  end

  def find_sets(hand)
    result = []
    hand.group_rank.each_value do |value|
      if value.size == 3
        result << PokerCerberina::Combination.new("set", value)
      end
    end
    result
  end

  def find_quads(hand)
    result = []
    hand.group_rank.each_value do |value|
      if value.size == 4
        result << PokerCerberina::Combination.new("quad", value)
      end
    end
    result
  end

  def find_full_house(hand)
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

  def find_flush(hand)
    result = []
    hand.group_suit.each_value do |value|
      if value.size == 5
        result << PokerCerberina::Combination.new("flush", value)
      end
    end
    result
  end

  def find_straight(cards)
    result = []
    result = cards.sort
    straight_down(result.last)
    for i in result.length - 1..1
      if straight_down(result[i])
        result[i - 5..i].each { |el| result << PokerCerberina::Combination.new("straight", el) }
      end
    end
    result.flatten!
  end
end
