defmodule Hand do
  @typedoc """
    List of cards. Must be ordered by card value, and secondarily by suit. Card.sort_order/1 is used to sort hands.
  """
  @type hand() :: [Card.card(), ...]

  @doc """
    Parses input into card tuples and sorts them by value.

    ## Examples

    iex> Hand.parse("2S 5C 4S AH AC")
    [{"A", "H"}, {"A", "C"}, {"5", "C"}, {"4", "S"}, {"2", "S"}]

  """
  @spec parse(String.t()) :: hand()
  def parse(input) do
    input
    |> String.split(" ")
    |> Enum.map(fn card -> String.graphemes(card) |> List.to_tuple() end)
    |> Enum.sort(&(Card.sort_order(&1) >= Card.sort_order(&2)))
  end

  @doc """
    Finds the highest rank in a hand. Returns a tuple containing the rank as an atom,
    and the set of cards which will determine the winner in case of a tie. The set of cards
    is ordered from most to least significant.
  """
  @spec rank(hand()) :: {atom(), [Card.value(), ...]}
  def rank(hand) do
    cond do
      value = straight_flush(hand) ->
        {:straight_flush, value}

      value = n_of_a_kind(hand, 4) ->
        {:four_of_a_kind, value}

      value = full_house(hand) ->
        {:full_house, value}

      value = flush(hand) ->
        {:flush, value}

      value = straight(hand) ->
        {:straight, value}

      value = n_of_a_kind(hand, 3) ->
        {:three_of_a_kind, value}

      value = two_pairs(hand) ->
        {:two_pairs, value}

      value = pair(hand) ->
        {:pair, value}

      true ->
        {:high_card, high_card(hand)}
    end
  end

  defp high_card(hand) do
    Enum.map(hand, &elem(&1, 0))
  end

  defp pair(hand) do
    n_of_a_kind(hand, 2)
  end

  defp two_pairs(hand) do
    frequencies = value_frequencies(hand)

    if frequencies |> Map.values() |> Enum.sort() == [1, 2, 2] do
      most_significant_frequencies(frequencies)
    else
      nil
    end
  end

  defp straight(hand) do
    if has_straight?(hand) do
      [hand |> hd() |> elem(0)]
    else
      nil
    end
  end

  defp flush(hand) do
    if all_same_suit?(hand) do
      [hand |> hd() |> elem(0)]
    else
      nil
    end
  end

  defp full_house(hand) do
    frequencies = value_frequencies(hand)

    found = frequencies |> Map.values() |> Enum.sort() == [2, 3]

    if found do
      most_significant_frequencies(frequencies)
    else
      nil
    end
  end

  defp n_of_a_kind(hand, count) do
    frequencies = value_frequencies(hand)

    if count in Map.values(frequencies) do
      most_significant_frequencies(frequencies)
    else
      nil
    end
  end

  defp straight_flush(hand) do
    if all_same_suit?(hand) and has_straight?(hand) do
      [hand |> hd() |> elem(0)]
    else
      nil
    end
  end

  defp all_same_suit?(hand) do
    hand
    |> Enum.map(&elem(&1, 1))
    |> Enum.uniq()
    |> length()
    |> Kernel.==(1)
  end

  defp has_straight?(hand) do
    values = Enum.map(hand, &Card.to_value/1)

    values
    |> Enum.map(&(&1 - Enum.min(values)))
    |> Kernel.==([4, 3, 2, 1, 0])
  end

  defp value_frequencies(hand) do
    hand
    |> Enum.map(&elem(&1, 0))
    |> Enum.frequencies()
  end

  defp most_significant_frequencies(frequencies) do
    frequencies
    |> Map.to_list()
    |> Enum.sort(fn {card_a, frequency_a}, {card_b, frequency_b} ->
      {frequency_a, Card.to_value(card_a)} >= {frequency_b, Card.to_value(card_b)}
    end)
    |> Enum.map(&elem(&1, 0))
  end
end
