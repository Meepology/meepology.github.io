---
layout: post
title:  "Chances of Going Bust"
date:   2017-02-04 17:35:55 +0000
category: cant-stop
notebook: "cant-stop/survival"
---

In this article, we will compute the chances of surviving a dice roll versus going bust once a player has already committed all 3 neutral markers. That is, we want to answer a question like: "what is the probability of going bust if I have already committed to 4, 7, and 11 this turn?". This is done by exhaustively enumerating all possible rolls and counting those with a pair whose sum is ~~committed~~.

After we have those probabilities, we then explore which sums when grouped together gives the highest chance of not going bust. If your first roll is (1, 2, 2, 5), should you go for (3, 7) or (4, 6)?

## Definitions

**bust** - aa

**neutral markers** - the chosen 3. in here, we are only interested when a player has already committed all 3 neutral markers as before that the probability of going bust is 0

**roll result** - the rolled. This will be written as 4 dice numbers inside a parenthesis in ascending order. Example: (2, 2, 3, 5)

**sum** - when pairing. This corresponds to the columns players climb during the game. The possible values are: 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, and 12.

**survive** - aa

## Computing the survive/bust probabilities


### Counting the sample space

First off, let's count the all the possible dice results. This is simply a combination with replacement with `n=6` and `r=4`.

$$
{
\binom {r + n - 1} {r} = \frac {(n + r - 1)!} {n! (r-1)!} = \frac {(6 + 4 - 1)!} {6! (4-1)!} = 126
}
$$

So there are 126 unique dice results.

### Unique Sums per dice roll

We are interested in the sums that occur at least once in a dice roll with no regard to how the dice were paired or how many times the sums came out.

| Roll Result  | Unique Sums   |
| :----------- | :-----------  |
| (1, 1, 1, 1) | (2)           |
| (1, 1, 1, 2) | (2, 3)        |
| (1, 1, 1, 3) | (2, 4)        |
| ...          | ...           |
| (2, 2, 5, 6) | (4, 7, 8, 11) |
| ...          | ...           |
| (6, 6, 6, 5) | (11, 12)      |
| (6, 6, 6, 6) | (12)          |

This was done for all 126 unique dice roll results. Get complete list here [link].

### Possible sum occurrences in all dice roll results

The table below shows the number of times each sum appears through all 126 unique dice rolls:

| Sum    | Count | Percentage  |
| :----- | :---- | :---------- |
| 2      | 21    | 16.67%      |
| 3      | 21    | 16.67%      |
| 4      | 41    | 32.54%      |
| 5      | 41    | 32.54%      |
| 6      | 60    | 47.62%      |
| 7      | 60    | 47.62%      |
| 8      | 60    | 47.62%      |
| 9      | 41    | 32.54%      |
| 10     | 41    | 32.54%      |
| 11     | 21    | 16.67%      |
| 12     | 21    | 16.67%      |

The consecutive similar counts here might be a surprise. For example, One might intuitively think that 3 should have a higher count than 2. This confusion comes from comparing the roll of 2 dice and summing that one pair with this game's roll of 4 dice and considering the sums of all 12 pairs.

In the case of rolling just two dice, a sum of 3 would have a slightly higher just of happening than a sum of 2. This is because 2 needs a (1, 1) to come out while 3 requires (1, 2)  or (2, 1), resulting in a 2 / 36 = 5.55% of happening vs 2's 1 / 36 = 2.77%.

In Can't Stop, a sum of 2 requires (1, 1, x, x). A sum of 3 requires (1, 2, x, x). This is the same.

The confusion comes from comparing Can't Stop with the rolling of 2 dice.

Same goes for 11 and 12.

### Some other thing

To get the probabilities of surviving given a sums, we must.
Since two sums appearing together in a dice roll are dependent events, we can not simply multiply these probabilities to compute the change of surviving.

<div>
  <div style="width: 50%; float: left;">
    <h3>Top 10</h3>
    {% include table.html data=site.data.cant_stop.survive.survive.top %}
  </div>
  <div style="width: 50%; float: right;">
    <h3>Bottom 10</h3>
    {% include table.html data=site.data.cant_stop.survive.survive.bottom %}
  </div>
  <div style="clear: both;"></div>
</div>

There are 165 possible commit states. Here's the [csv]().

That's it. But are questions about it such as:

* For the states tied at top 3 with `count=106`, it's not surprising that (6, 7, 8) is there. But why are the other two (4, 6, 8) and (6, 8, 10)? Where is 5 and 9? There's seems to be a lack of odd numbers in the top 10.
* The bottom 4 with `count=55` is just  2,3,11,12 in different combinations, nothing surprising.

We will be exploring these questions and more in the next section.

## Analysis

Some graphs first.

### Here we break it down

The first one box plot, for example, is for all the states from (2,1,1)

![Something](/assets/images/cant-stop/probs12.png)

Odd numbers seem to do poorly. In particular:

* The mean probabilities of 6 and 8 are greater than 7's.
* The mean probability of 2 is greater than 3, same with 11 and 12.
* The mean probability of 4 is greater than 5, same with 10 and 9.

I expected something that looked like a pyramid peaking at 7 (as the game looks like) but it's not what we have.

### What's up with 7?

### What's up with 2 vs 3 and 11 vs 12?


## Heuristics

With the above insights, we now come up with

These can be all be enumerated in python with:

``` python
import itertools
itertools.combinations_with_replacement([1, 2, 3, 4, 5, 6], 4)
```
