defmodule Poker do
  @moduledoc """
  Documentation for `Poker`.
  """

  @doc """
  Compare the scores of two poker hands, and decide who wins.

  """

  # @spec rank(String.t(), String.t()) :: {atom(), atom(), atom(), String.t()}
  def rank(black_hand, white_hand) do
    # {:ok, :white, :high_card, {"A", "H"}}
    black_hand
    |> Hand.parse()
    |> Hand.rank()

    # find the highest scoring set in a hand

    # compare the two hands
  end
end
