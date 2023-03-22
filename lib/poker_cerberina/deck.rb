class PokerCerberina::Deck
  def initialize
    @deck = []
    PokerCerberina::SUIT.each do |s|
      PokerCerberina::RANK.each do |r|
        @deck << PokerCerberina::Card.new(r, s)
      end
    end
  end

  def shuffle
    @deck.shuffle!
    self
  end

  def select_card
    @deck.shift
  end
end
