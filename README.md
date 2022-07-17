# Poker


Compare the scores of two poker hands, and decide who wins. Returns a tuple containing the winning player, the rank of their hand, and the value of the card which decided the winner. In case of a tie, returns the most significant card for the hand

## Examples

```
iex> Poker.compare("AH KH AS KS AD", "KH AD KS AS KC")
{:black, :full_house, "A"}

iex> Poker.compare("TS TH AC AS 5H", "TC TD AD AH 6D")
{:white, :two_pairs, "6"}

iex> Poker.compare("AH 8C JS 6H 3S", "AD 8H JD 6S 3H")
{:tie, :high_card, "A"}
```
