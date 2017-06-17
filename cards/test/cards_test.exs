defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck makes 16 cards" do
    deck_length = Cards.create_deck |> length
    assert deck_length == 16
  end

  test "Shuffling the deck" do
     deck = Cards.create_deck
     assert deck != Cards.shuffle(deck)
  end

  test "Deal for a deck with a size `x` should return hand with `x` ele" do
    deck = Cards.create_deck
    {hand, _deck} = Cards.deal(deck, 4)
    assert length(hand) == 4
  end

end
