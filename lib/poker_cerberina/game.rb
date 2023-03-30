class PokerCerberina::Game
  attr_reader :players, :deck

  def initialize(count_of_players)
    raise "Invalid number of players. Should be 2-10" unless (2..10).include? count_of_players
    players = []
    deck = PokerCerberina::Deck.new
    count_of_players.times do |player|
      players << PokerCerberina::Player.new
    end
    @players = players
    @deck = deck
  end

  def deal(count_of_cards)
    players.each do |player|
      player.hand = PokerCerberina::Hand.new (deck.select_cards(count_of_cards))
    end
  end

  def winning_player
    best_combinations = players.map { |player| player.best_combination }
    players[best_combinations.index(best_combinations.max)]
  end
end
