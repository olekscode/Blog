# Design Coffee Club: Double Dispatch

Today at our weekly Desigm Coffee Club meeting at [RMoD](https://rmod.inria.fr), we discussed double dispatch - a process to choose which method to invoke depending on the receiver and the argument type.

To illustrate this process, we will implement a simple Rock-Paper-Scissors game. Then we will try to extend a game with new figures such as Lizard and Spock.

## Rock-Paper-Scissors Game

This simple game that is familiar to nearly every child in the world originated in ancient China and Japan around 200 BC. In the early version of the game, the thumb represented the _"Frog"_, little finger was the _"Slug"_, and the index finger - the _"Snake"_ (see [The Official History of Rock Paper Scissors](https://wrpsa.com/the-official-history-of-rock-paper-scissors/) and [Rock, Paper, Scissors Goes Back To Ancient China](https://historydaily.org/rock-paper-scissors-ancient-china)). The modern westernized version of the game that is known globally uses Rock, Paper, and Scissors. And the rules are the following:

- Scissors cuts Paper
- Paper covers Rock
- Rock crushes Scissors

![](figures/RockPaperScissorsDrawing.png)

Let's implement this game in Python in a simple and naïve way. We can write a small function `play_rock_paper_scissors()` that takes two arguments. Each argument is a string with three possible values: `'Rock'`, `'Paper'`, or `'Scissors'`. The output of the function is also a string with four possible values `'Rock'`, `'Paper'`, `'Scissors'`, or `'Draw'`.

```Python
def play_rock_paper_scissors(first_hand, second_hand):
    if (first_hand == second_hand):
        return 'Draw'

    if (first_hand == 'Rock'):
        if (second_hand == 'Paper'):
            return 'Paper'
        else:
            return 'Rock'
    elif (first_hand == 'Paper'):
        if (second_hand == 'Rock'):
            return 'Paper'
        else:
            return 'Scissors'
    else:
        if (second_hand == 'Rock'):
            return 'Rock'
        else:
            return 'Scissors'

```

Let's write a unit test to validate the correctness of this function.

```Python
import unittest
from rps_naive import play_rock_paper_scissors

class TestRockPaperScissors(unittest.TestCase):
    def test_rock_against_rock(self):
        self.assertEqual(play_rock_paper_scissors('Rock', 'Rock'), 'Draw')
        
    def test_rock_against_paper(self):
        self.assertEqual(play_rock_paper_scissors('Rock', 'Paper'), 'Paper')
        
    def test_rock_against_scissors(self):
        self.assertEqual(play_rock_paper_scissors('Rock', 'Scissors'), 'Rock')
        
    def test_paper_against_rock(self):
        self.assertEqual(play_rock_paper_scissors('Paper', 'Rock'), 'Paper')
        
    def test_paper_against_paper(self):
        self.assertEqual(play_rock_paper_scissors('Paper', 'Paper'), 'Draw')
        
    def test_paper_against_scissors(self):
        self.assertEqual(play_rock_paper_scissors('Paper', 'Scissors'), 'Scissors')
        
    def test_scissors_against_rock(self):
        self.assertEqual(play_rock_paper_scissors('Scissors', 'Rock'), 'Rock')
        
    def test_scissors_against_paper(self):
        self.assertEqual(play_rock_paper_scissors('Scissors', 'Paper'), 'Scissors')
        
    def test_scissors_against_scissors(self):
        self.assertEqual(play_rock_paper_scissors('Scissors', 'Scissors'), 'Draw')
        
if __name__ == '__main__':
    unittest.main()
```

As you can see below, all tests are passing.

```
Mac:src oleks$ python -m unittest test_naive.py -v
test_paper_against_paper (test_naive.TestRockPaperScissors) ... ok
test_paper_against_rock (test_naive.TestRockPaperScissors) ... ok
test_paper_against_scissors (test_naive.TestRockPaperScissors) ... ok
test_rock_against_paper (test_naive.TestRockPaperScissors) ... ok
test_rock_against_rock (test_naive.TestRockPaperScissors) ... ok
test_rock_against_scissors (test_naive.TestRockPaperScissors) ... ok
test_scissors_against_paper (test_naive.TestRockPaperScissors) ... ok
test_scissors_against_rock (test_naive.TestRockPaperScissors) ... ok
test_scissors_against_scissors (test_naive.TestRockPaperScissors) ... ok

----------------------------------------------------------------------
Ran 9 tests in 0.000s

OK
```

## Problem: Adding Lizard and Spock

The problem with our implementation is that it can not be easily extended without modifying the existing code. In [The Big Bang Theory, Season 2 Ep. 5, "The Lizard-Spock Expansion"](https://youtu.be/Kov2G0GouBw), Sheldon Cooper introduced his friends to an extended version of the game. It included two additional figures: Lizard and Spock:

- Scissors cuts Paper
- Paper covers Rock
- Rock crushes Lizard
- Lizard poisons Spock
- Spock smashes Scissors
- Scissors decapitates Lizard
- Lizard eats Paper
- Paper disproves Spock
- Spock vaporizes Rock
- (and as it always has) Rock crushes Scissors

![](figures/RockPaperScissorsLizardSpock.svg)

This simple change has exponentially increased the number of combinations. But more importantly, to introduce it, we would have to modify the same function that was already implemented and tested. This means that our design violates the open-closed principle: _"software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification"_.

The extended implementation would look something like this:

```Python
def play_rock_paper_scissors_lizard_spock(first_hand, second_hand):
    if (first_hand == 'Rock'):
        if (second_hand == 'Rock'):
            return 'Draw'
        elif (second_hand == 'Paper'):
            return 'Paper'
        elif (second_hand == 'Scissors'):
            return 'Rock'
        elif (second_hand == 'Lizard'):
            return 'Rock'
        else:
            return 'Spock'
    elif (first_hand == 'Paper'):
        if (second_hand == 'Rock'):
            return 'Paper'
        elif (second_hand == 'Paper'):
            return 'Draw'
        elif (second_hand == 'Scissors'):
            return 'Scissors'
        elif (second_hand == 'Lizard'):
            return 'Lizard'
        else:
            return 'Paper'
    elif (first_hand == 'Scissors'):
        if (second_hand == 'Rock'):
            return 'Rock'
        elif (second_hand == 'Paper'):
            return 'Scissors'
        elif (second_hand == 'Scissors'):
            return 'Draw'
        elif (second_hand == 'Lizard'):
            return 'Scissors'
        else:
            return 'Spock'
    elif (first_hand == 'Lizard'):
        if (second_hand == 'Rock'):
            return 'Rock'
        elif (second_hand == 'Paper'):
            return 'Lizard'
        elif (second_hand == 'Scissors'):
            return 'Scissors'
        elif (second_hand == 'Lizard'):
            return 'Draw'
        else:
            return 'Lizard'
    else:
        if (second_hand == 'Rock'):
            return 'Spock'
        elif (second_hand == 'Paper'):
            return 'Paper'
        elif (second_hand == 'Scissors'):
            return 'Spock'
        elif (second_hand == 'Lizard'):
            return 'Lizard'
        else:
            return 'Draw'

```

## Better Implementation Using Double Dispatch

The more agile way to implement the Rock-Paper-Scissors game involves double dispatch. We implement each figure as a class and add a method `self.play_against(other)` to each class. We do not know the type of the `other` but we know the type of `self`. So in each implementation of `play_against()` we delegate the responsibility to another object, "telling" it against whom it is playing:

```Python
class Rock:
    def play_against(self, other):
        return other.play_against_rock(self)
        
class Paper:
    def play_against(self, other):
        return other.play_against_paper(self)
        
class Rock:
    def play_against(self, other):
        return other.play_against_scissors(self)  
```

This delegation is called "double dispatch" because the method is dispatched twice: first to `self` and then to `other`.

Below is the full implementation of the game. We provide a common superclass `Hand` to represent all figures. For simplicity, we also implement `Draw` as a class.

![](figures/RockPaperScissors.png)

```Python
class Rock(Hand):
    def play_against(self, other):
        return other.play_against_rock(self)
    
    def play_against_rock(self, other):
        return Draw()
        
    def play_against_paper(self, other):
        return other
        
    def play_against_scissors(self, other):
        return self
```
```Python
class Paper(Hand):      
    def play_against(self, other):
        return other.play_against_paper(self)
    
    def play_against_rock(self, other):
        return self
        
    def play_against_paper(self, other):
        return Draw()
        
    def play_against_scissors(self, other):
        return other
```
```Python
class Scissors(Hand):     
    def play_against(self, other):
        return other.play_against_scissors(self)
    
    def play_against_rock(self, other):
        return other
        
    def play_against_paper(self, other):
        return self
        
    def play_against_scissors(self, other):
        return Draw()
```

To add Lizard and Spock to this game, we only need to implement them as classes and add two new methods to every existing class: `play_against_lizard()` and `play_against_spock()`. This might seem a bit verbose. After all, we had to write more code than in the first example. But the key benefit is that now we can extend the game without modifying any of the existing methods. 

![](figures/RockPaperScissorsLizardSpock.png)