defmodule Poker do
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
  and the value of the card which decided the winner. In case of a tie, returns the most significant card for the hand

  ## Examples
  iex> Poker.compare("AH KH AS KS AD", "KH AD KS AS KC")
  {:black, :full_house, "A"}

  iex> Poker.compare("TS TH AC AS 5H", "TC TD AD AH 6D")
  {:white, :two_pairs, "6"}

  iex> Poker.compare("AH 8C JS 6H 3S", "AD 8H JD 6S 3H")
  {:tie, :high_card, "A"}

  """
  @spec compare(String.t(), String.t()) ::
          {:black | :white | :tie, Hand.rank(), Card.value()}
  def compare(black_hand, white_hand) do
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
        {:black, black_rank, hd(black_cards)}

      white_score > black_score ->
        {:white, white_rank, hd(white_cards)}

      true ->
        {winner, tiebreaker_card} = tiebreaker(black_cards, white_cards)

        case winner do
          :black ->
            {:black, black_rank, tiebreaker_card}

          :white ->
            {:white, white_rank, tiebreaker_card}

          _ ->
            {:tie, black_rank, hd(black_cards)}
        end
    end
  end

  defp tiebreaker(black_cards, white_cards), do: Enum.zip(black_cards, white_cards) |> do_tiebreaker()

  defp do_tiebreaker([]), do: {nil, nil}

  defp do_tiebreaker([{black_card, white_card} | tail]) do
    black_val = Card.to_value(black_card)
    white_val = Card.to_value(white_card)

    cond do
      black_val > white_val ->
        {:black, black_card}

      white_val > black_val ->
        {:white, white_card}

      true ->
        do_tiebreaker(tail)
    end
  end
end
