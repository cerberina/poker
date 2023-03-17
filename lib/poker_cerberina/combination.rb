class PokerCerberina::Combination
  include Comparable
  attr_reader :type, :cards

  def initialize(type, cards)
    @type = type
    @cards = cards
  end

  def ==(other)
    self.cards - other.cards == []
  end

  def <=>(other)
    if type == other.type
      if ["pair", "set", "quad"].include? type
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
