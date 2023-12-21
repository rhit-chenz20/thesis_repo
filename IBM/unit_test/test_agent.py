import unittest
from src.agent import Male, Female
from src.randomizer import Randomizer
from src.strategy import MaleHonestStra, MaleAllLie, MaleWorseLieMore, MaleCostly
from src.strategy import FemaleCaution, FemalePosLin, FemaleNegLin

class MultiplyTestCase(unittest.TestCase):

    def setUp(self):
        self.ran = Randomizer()
        
        self.mHonest = MaleHonestStra()
        self.mLie = MaleAllLie()
        self.mWorseLieMore = MaleWorseLieMore()
        self.mCostly = MaleCostly()
        
        self.fCaution = FemaleCaution()
        self.fPosLin = FemalePosLin()
        self.fNegLin = FemaleNegLin()
        
        self.male = Male(0.1, [], )
        self.female = Female(0.1, [], )

    def test_mstra_1(self):
        pass

    def test_mstra_2(self):
        pass
    
    def test_mstra_3(self):
        pass

    def test_mstra_4(self):
        pass
    
    def test_fstra_1(self):
        pass

    def test_fstra_2(self):
        pass
    
    def test_fstra_3(self):
        pass

