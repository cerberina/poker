module PokerCerberina
  SUIT = ["♠︎", "♣︎", "♥︎", "♦︎"]
  RANK = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
  HIERARCHY = ["kiker", "pair", "two_pairs", "set", "straight", "flush", "full_house", "quad", "straight_flush", "royal_flush"]
end

require "poker_cerberina/combination_search"
require "poker_cerberina/combination"
require "poker_cerberina/card"
require "poker_cerberina/hand"
