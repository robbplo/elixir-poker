defmodule HandTest do
  use ExUnit.Case
  doctest Hand

  test "straight flush" do
    assert {:straight_flush, "T"} ==
             "TH 9H 6H 8H 7H"
             |> Hand.parse()
             |> Hand.rank()
  end

  test "four of a kind" do
    assert {:four_of_a_kind, "A"} ==
             "AS AH AC AD 3S"
             |> Hand.parse()
             |> Hand.rank()
  end

  test "full house" do
    assert {:full_house, "K"} ==
             "2D KH 2H KD KC"
             |> Hand.parse()
             |> Hand.rank()
  end

  test "flush" do
    assert {:flush, "A"} ==
             "2D 4D 8D KD AD"
             |> Hand.parse()
             |> Hand.rank()
  end

  test "straight" do
    assert {:straight, "Q"} ==
             "9H JD QH TS 8C"
             |> Hand.parse()
             |> Hand.rank()
  end

  test "three of a kind" do
    assert {:three_of_a_kind, "5"} ==
             "5D AH 5C 5H 3D"
             |> Hand.parse()
             |> Hand.rank()
  end

  test "two pairs" do
    assert {:two_pairs, "K"} ==
             "2C 4H 2H 4S KD"
             |> Hand.parse()
             |> Hand.rank()
  end

  test "pair" do
    assert {:pair, "8"} ==
             "9H KC 8S 8C 2D"
             |> Hand.parse()
             |> Hand.rank()
  end
end
