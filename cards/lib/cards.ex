defmodule Cards do
	@moduledoc """
		Provides methods for creating and playing with cards deck
	"""

	@doc """
		Returns a list of playing cards
	"""
	def create_deck() do
		suits = ~w(Clubs Diamonds Hearts Spades)
		cards = ~w(Ace Two Three Four)
		for suit <- suits, card <- cards do
			"#{card} of #{suit}"
		end
	end

	@doc """
		Devides a `deck` into hand and the reminder of the deck.
		The `size` argument indicates size of hand.

	## Examples:
		iex> deck = Cards.create_deck()
		iex> {hand, _deck} = Cards.deal(deck, 1)
		iex> hand
		["Ace of Clubs"]

	"""
	def deal(deck, size) do
		Enum.split(deck, size)
	end

	def shuffle(deck) do
		Enum.shuffle(deck)
	end

	@doc """
		Determines if given deck contains given card
		### Examples

			iex>deck = Cards.create_deck()
			iex>Cards.contains?(deck, "Ace of Hearts")
			true


	"""
	def contains?(deck, ele) do
		Enum.member?(deck, ele)
	end

	def save(deck, filename) do
		deck_binary = :erlang.term_to_binary(deck)
		File.write(filename, deck_binary)
	end

	def load(filename) do
		case File.read(filename) do
			{:ok, content} -> :erlang.binary_to_term(content)
			{:error, error_message} -> "Something went wrong because of #{error_message}"
		end
	end

	def create_hand(hand_size) do
		create_deck()
			|>  shuffle()
			|> deal(hand_size)
	end
end
