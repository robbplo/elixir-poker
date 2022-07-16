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
  Compare the scores of two poker hands, and decide who wins. Returns a tuple containing the winning player, the rank of their hand,
  and a list of cards that were used in deciding the winner.
  """
  @spec rank(String.t(), String.t()) :: {:black|:white, atom(), [Card.value(), ...]} | {:tie, nil, nil}
  def rank(black_hand, white_hand) do
    {black_rank, black_cards} =
      black_hand
      |> Hand.parse()
      |> Hand.rank()

    {white_rank, white_cards} =
      white_hand
      |> Hand.parse()
      |> Hand.rank()

    black_score = @rank_scores[black_rank]
    white_score = @rank_scores[white_rank]

    cond do
      black_score > white_score ->
        {:black, black_rank, [hd(black_cards)]}

      white_score > black_score ->
        {:white, white_rank, [hd(white_cards)]}

      true ->
        {winner, tiebreaker_cards} = tiebreaker(black_cards, white_cards)

        case winner do
          :black ->
            {:black, black_rank, tiebreaker_cards}

          :white ->
            {:white, white_rank, tiebreaker_cards}

          _ ->
            {:tie, nil, nil}
        end
    end
  end

  defp tiebreaker(black_cards, white_cards) do
    Enum.zip(black_cards, white_cards)
    |> do_tiebreaker()
  end

  defp do_tiebreaker(zipped_cards, significant_cards \\ [])
  defp do_tiebreaker([], _), do: nil

  defp do_tiebreaker([{black, white} = card | t], significant_cards) do
    black_val = Card.to_value(black)
    white_val = Card.to_value(white)

    cond do
      black_val > white_val ->
        {:black, [black | significant_cards |> Enum.map(&elem(&1, 0)) |> Enum.reverse()]}

      white_val > black_val ->
        {:white, [white | significant_cards |> Enum.map(&elem(&1, 1)) |> Enum.reverse()]}

      true ->
        do_tiebreaker(t, [card | significant_cards])
    end
  end
end
