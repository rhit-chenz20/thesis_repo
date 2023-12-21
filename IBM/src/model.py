from .agent import Female, Male
from .selection import Selection
from .fitnessFunction import FitnessFunction
from .dataProcess import DataProcessor
from .randomizer import Randomizer

class SignalStrategyModel():
    """
    args: 
        popSize,
        maxGen,
        sel,
        seed, 
        debug
    """
    def __init__(
        self,
        args
    ):
        self.ran = Randomizer(args.seed)
        seed = self.ran.get_seed()
        self.dataPro = DataProcessor(seed, args.filename)
        self.maxGen = args.maxGen
        self.females = []
        self.males = []
        self.generation = 0
        self.sel = Selection.get_sel(args.sel)
        self.produce_pop()
    
    def produce_pop(self):
        """
        Generate female population
        """

    def start(self):
        """
        Start the evolution
        """
        for x in range(self.maxGen):
            self.evolve()
        self.end()

    def end(self):
        """
        End the evolution
        """
        print("End of simulation")
        self.dataPro.close(self.pop)

    def evolve(self):
        self.step()
        if self.generation < self.maxGen-1:
            self.reproduce()
            self.generation += 1

    def step(self):
        for female in self.females:
            male = self.dataPro.getRandomMale(self.males)
            female.mate(male)
            female.calFitness()
        
        for male in self.males:
            male.calFitness()

    def reproduce(self):
        """
        Generate the next generation
        """
        parent = self.sel.choose_parent(self.females, self.males)
        