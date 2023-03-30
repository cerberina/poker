require "faker"

class PokerCerberina::Player
  attr_accessor :hand
  attr_reader :name

  def initialize
    @hand = hand
    @name = Faker::Name.name
  end

  def best_combination
    combinations = []
    search = PokerCerberina::CombinationSearch.new(hand)
    #search.find_royal_flush unless search.find_royal_flush.empty?
    combinations << search.find_pairs
    combinations << search.find_two_pairs
    combinations << search.find_sets
    combinations << search.find_straight
    combinations << search.find_flush
    combinations << search.find_full_house
    combinations << search.find_quads
    combinations << search.find_straight_flush
    combinations << search.find_royal_flush
    return best = combinations.max if combinations.any?
    search.find_kiker
  end
end
