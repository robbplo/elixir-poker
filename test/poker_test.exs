defmodule PokerTest do
  use ExUnit.Case
  doctest Poker

  test "ranks a straight flush" do
    #assert {:straight_flush, 10} = Poker.rank("TS 9S 8S 7S 6S", "2C, 3H, 4S, 8C, AH")
  end
end
