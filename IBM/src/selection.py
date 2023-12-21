from abc import abstractmethod
from .randomizer import Randomizer

class Selection():
    def get_sel(num):
        if num == 0 :
            return RouletteSelection()

    @abstractmethod
    def choose_parent(self, inds, ran):
        pass

class RouletteSelection(Selection):
    def __init__(
        self
    ):
        super().__init__()

    def choose_parent(self, inds, ran: Randomizer):
        """
        
        """
        parent = inds[1]
        return parent

