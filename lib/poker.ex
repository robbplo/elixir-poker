defmodule Poker do
  @moduledoc """
  Documentation for `Poker`.
  """
  @rank_scores %{
    straight_flush: 8,
    four_of_a_kind: 7,
    full_house: 6,
    flush: 5,
    straight: 4,
    three_of_a_kind: 3,
    two_pairs: 2,
    pair: 1,
    high_card: 0
  }

  @doc """
  Compare the scores of two poker hands, and decide who wins.
  """
  @spec rank(String.t(), String.t()) :: {atom(), atom(), Card.value()}
  def rank(black_hand, white_hand) do
    {black_rank, black_rank_value} =
      black_hand
      |> Hand.parse()
      |> Hand.rank()

    {white_rank, white_rank_value} =
      white_hand
      |> Hand.parse()
      |> Hand.rank()

    black_score = @rank_scores[black_rank]
    white_score = @rank_scores[white_rank]

    cond do
      black_score > white_score ->
        {:black, black_rank, black_rank_value}

      white_score > black_score ->
        {:white, white_rank, white_rank_value}

      true ->
        black_rank_score = Card.to_value({black_rank_value, nil})
        white_rank_score = Card.to_value({white_rank_value, nil})

        cond do
          black_rank_score > white_rank_score ->
            {:black, black_rank, black_rank_value}

          white_rank_score > black_rank_score ->
            {:white, white_rank, white_rank_value}

          true ->
            {:tie, nil, nil}
        end
    end
  end
end
