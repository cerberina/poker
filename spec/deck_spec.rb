require "rspec"
require "poker_cerberina"

describe "#initialize" do
  it "creates new deck with 52 cards" do
    deck = PokerCerberina::Deck.new
    expect(deck.size).to eq 52
  end
end

describe "#shuffle" do
  it "changes the order of cards in deck, but doesn't change the count of cards" do
    deck = PokerCerberina::Deck.new
    first_10_cards_before = deck.peak_cards(10)
    deck.shuffle
    first_10_cards_after = deck.peak_cards(10)
    expect(first_10_cards_before).not_to eq first_10_cards_after
  end
end

describe "#peak_cards" do
  it "peaking cards doesn't change the deck" do
    deck = PokerCerberina::Deck.new
    first_10_cards_1 = deck.peak_cards(10)
    first_10_cards_2 = deck.peak_cards(10)
    expect(first_10_cards_1).to eq first_10_cards_2
  end
end

describe "#select_cards" do
  it "selecting cards changes the deck" do
    deck = PokerCerberina::Deck.new
    first_10_cards_1 = deck.select_cards(10)
    first_10_cards_2 = deck.select_cards(10)
    expect(first_10_cards_1).not_to eq first_10_cards_2
  end
end
