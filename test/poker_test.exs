defmodule PokerTest do
  use ExUnit.Case
  doctest Poker

  test "black wins with straight flush" do
    assert {:black, :straight_flush, ["T"]} = Poker.rank("TS 9S 8S 7S 6S", "2C 3H 4S 8C AH")
  end

  test "white wins with full house" do
    assert {:white, :full_house, ["3"]} = Poker.rank("KD KH QS QC 2S", "3H 3D 3C 2S 2D")
  end

  test "tiebreaker straight flush" do
    assert {:black, :straight_flush, ["K"]} = Poker.rank("KD QD JD TD 9D", "QD JD TD 9D 8D")
  end

  test "tiebreaker four of a kind" do
    assert {:white, :four_of_a_kind, ["4"]} = Poker.rank("3S 3D 3C 3H 4S", "4S 4D 4C 4H 3S")
  end

  test "tiebreaker full house" do
    assert {:black, :full_house, ["8"]} = Poker.rank("8D 8C 8H 7D 7S", "7D 7S 7C 8D 8H")
  end

  test "tiebreaker flush" do
    assert {:white, :flush, ["J"]} = Poker.rank("TH 4H 5H 9H 2H", "JS 8S 8S 3S 4S")
  end

  test "tiebreaker straight" do
    assert {:black, :straight, ["7"]} = Poker.rank("3H 4D 7C 6S 5H", "2H 3D 6C 5S 4H")
  end

  test "tiebreaker three of a kind" do
    assert {:white, :three_of_a_kind, ["Q"]} = Poker.rank("JS JC JH QD 2S", "QS QH QD JS 2D")
  end

  test "two pairs highest pairs win" do
    # todo
  end

  test "tiebreaker two pairs" do
    assert {:black, :two_pairs, ["A"]} = Poker.rank("2S 2D 3H 3C AS", "2S 2D 3H 3C KS")
  end


  # todo: Hands which both contain a pair are ranked by the value of the cards forming the pair. If these values are the same, the hands are ranked by the values of the cards not forming the pair, in decreasing order.
end
