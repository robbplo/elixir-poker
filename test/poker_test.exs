defmodule PokerTest do
  use ExUnit.Case
  doctest Poker

  test "black wins with straight flush" do
    assert {:black, :straight_flush, "T"} = Poker.compare("TS 9S 8S 7S 6S", "2C 3H 4S 8C AH")
  end

  test "tie straight flush" do
    assert {:tie, :straight_flush, "K"} = Poker.compare("KD QD JD TD 9D", "KH QH JH TH 9H")
  end

  test "tiebreaker straight flush" do
    assert {:black, :straight_flush, "K"} = Poker.compare("KD QD JD TD 9D", "QD JD TD 9D 8D")
  end

  test "white wins with full house" do
    assert {:white, :full_house, "3"} = Poker.compare("KD KH QS QC 2S", "3H 3D 3C 2S 2D")
  end

  test "tiebreaker full house" do
    assert {:black, :full_house, "8"} = Poker.compare("8D 8C 8H 7D 7S", "7D 7S 7C 8D 8H")
  end

  test "tiebreaker four of a kind" do
    assert {:white, :four_of_a_kind, "4"} = Poker.compare("3S 3D 3C 3H 4S", "4S 4D 4C 4H 3S")
  end

  test "tiebreaker flush" do
    assert {:white, :flush, "J"} = Poker.compare("TH 4H 5H 9H 2H", "JS 8S 8S 3S 4S")
  end

  test "tie flush" do
    assert {:tie, :flush, "9"} = Poker.compare("9H 7H 6H 5H 4H", "9C 7C 6C 5C 4C")
  end

  test "tiebreaker straight" do
    assert {:black, :straight, "7"} = Poker.compare("3H 4D 7C 6S 5H", "2H 3D 6C 5S 4H")
  end

  test "tie straight" do
    assert {:tie, :straight, "8"} = Poker.compare("8H 7D 6H 5D 4H", "8D 7H 6D 5H 4D")
  end

  test "tiebreaker three of a kind" do
    assert {:white, :three_of_a_kind, "Q"} = Poker.compare("JS JC JH QD 2S", "QS QH QD JS 2D")
  end

  test "two pairs highest pairs win" do
    assert {:black, :two_pairs, "4"} = Poker.compare("4S 4D 2H 2C KS", "2S 2D 3H 3C AS")
  end

  test "tiebreaker two pairs" do
    assert {:black, :two_pairs, "A"} = Poker.compare("2S 2D 3H 3C AS", "2S 2D 3H 3C KS")
  end

  test "tie two pairs" do
    assert {:tie, :two_pairs, "6"} = Poker.compare("5H 5C 6H 6C AS", "5D 5S 6D 6S AH")
  end

  test "white wins high card" do
    assert {:white, :high_card, "K"} = Poker.compare("QD JC 2S 6S 5D", "7D 4C 2S KH TC")
  end

  test "tie high card" do
    assert {:tie, :high_card, "K"} = Poker.compare("KH 4H 3H 8H 9D", "KD 4D 3D 8D 9H")
  end

end
