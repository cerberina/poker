class PokerCerberina::CombinationSearch
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
    pair = []
    set = []
    result = []
    hand.group.each_value do |value|
      if value.size == 2
        pair << value
      elsif value.size == 3
        set << value
      end
    end
    if !pair.empty? && !set.empty?
      result << PokerCerberina::Combination.new("fullhouse", (pair + set).flatten)
    end
    result
  end

  def find_flash(hand)
    result = []
    #require "debug"
    #debugger
    hand.each do |card|
      if !card.suit == hand.first.suit
        return []
      end
    end
    result << PokerCerberina::Combination.new("flash", hand.cards)
  end
end
