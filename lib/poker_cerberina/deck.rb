class PokerCerberina::Deck
  def initialize
    @deck = []
    PokerCerberina::SUIT.each do |s|
      PokerCerberina::RANK.each do |r|
        deck << PokerCerberina::Card.new(r, s)
      end
    end
  end

  def shuffle
    deck.shuffle!
    self
  end

  def size
    deck.size
  end

  def select_cards(number)
    deck.shift(number)
  end

  def peak_cards(number)
    deck[0..number - 1]
  end

  private

  attr_accessor :deck
end
