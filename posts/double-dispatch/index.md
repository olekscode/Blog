# Design Coffee Club: Double Dispatch

Today at our weekly Desigm Coffee Club meeting at [RMoD](https://rmod.inria.fr), we discussed double dispatch - a process to choose which method to invoke depending on the receiver and the argument type.

## Rock-Paper-Scissors Game

Consider an example of implementing a simple rock-paper-scissors game. For those of you who tend to forget the rules (like I do) here they are:

- Scissors cuts Paper
- Paper covers Rock
- Rock crushes Scissors

![](figures/RockPaperScissorsDrawing.png)

Let's implement this game in Python in a simple and naïve way. The game can be implemented as a function `play_rock_paper_scissors()` that takes two arguments. Each argument is a string with three possible values: `'Rock'`, `'Paper'`, or `'Scissors'`. The output of the function is also a string with four possible values `'Rock'`, `'Paper'`, `'Scissors'`, or `'Draw'`.

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

[The Big Bang Theory, Season 2 Ep. 5, "The Lizard-Spock Expansion"](https://youtu.be/Kov2G0GouBw)

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

```Python
class Hand:
    def is_rock(self):
        return False
        
    def is_paper(self):
        return False
        
    def is_scissors(self):
        return False
        
    def is_draw(self):
        return False
```
```Python   
class Draw(Hand):
    def is_draw(self):
        return True
```
```Python
class Rock(Hand):
    def is_rock(self):
        return True
                
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
    def is_paper(self):
        return True
                
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
    def is_scissors(self):
        return True
                
    def play_against(self, other):
        return other.play_against_scissors(self)
    
    def play_against_rock(self, other):
        return other
        
    def play_against_paper(self, other):
        return self
        
    def play_against_scissors(self, other):
        return Draw()
```

![](figures/RockPaperScissors.png)

![](figures/RockPaperScissorsLizardSpock.png)