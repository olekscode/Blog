class Hand:
    def is_rock(self):
        return False
        
    def is_paper(self):
        return False
        
    def is_scissors(self):
        return False
        
    def is_draw(self):
        return False
        
        
class Draw(Hand):
    def is_draw(self):
        return True
        

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