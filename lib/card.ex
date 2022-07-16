defmodule Card do
  @typedoc """
  Describes the suit of a playing card. Valid values are: "C", "D", "H", "S".
  """
  @type suit() :: String.t()

  @typedoc """
  Describes the value of a playing card. Can a string between 2 and 9, or one of "T", J", "Q", "K", "A".
  """
  @type value() :: String.t()

  @typedoc """
  A tuple representing a card by value and suit.
  """
  @type card() :: {value(), suit()}

  @values %{
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9,
    "T" => 10,
    "J" => 11,
    "Q" => 12,
    "K" => 13,
    "A" => 14
  }

  @suits %{
    "C" => 1,
    "D" => 2,
    "H" => 3,
    "S" => 4
  }

  @spec to_value(card() | value()) :: integer()
  def to_value({value, _}), do: @values[value]
  def to_value(value), do: @values[value]

  @spec to_suit(card()) :: integer()
  def to_suit({_, suit}), do: @suits[suit]

  @spec sort_order(card()) :: integer()
  def sort_order(card) do
    to_value(card) * 10 + to_suit(card)
  end
end
