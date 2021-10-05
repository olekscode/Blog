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