from abc import abstractmethod
from .randomizer import Randomizer
from .strategy import Strategy
from .fitnessFunction import FitnessFunction

class Agent():
    def __init__(
        self,
        mutated_range,
        genome,
        strategy,
        fit_function
    ):
        """
        Create a new Agent.
        Genome = [c, v1, v2, q, v3, v4]
        c, v1, v2 => male strategy
        v3, v4 => female strategy
        TODO: ASSUMPTION if v3 should be the same as c
        """
        self.fitness = 0
        self.mates = []
        self.genome = genome
        self.strategy = strategy
        self.mutated_range = mutated_range
        self.fit_function = fit_function
    
    def mutate(self, ran: Randomizer):
        for i in range(len(self.genome)):
            prob = ran.get_ran_float(0, 1)
            if(prob <= self.mutation_sigma):
                # mutate the loci
                loci = self.genome[i]
                self.genome[i] = ran.get_nor_val(loci, self.mutated_range)
    
    def interact(self, ind):
        pass
    
    def cal_fitness(self):
        self.fit_function.cal_fitness(self)
            
    def __lt__(self, otherF):
        return self.fitness < otherF.fitness

class Male(Agent):
    def __init__(
        self,
        mutated_range,
        genome,
        strategy: Strategy
    ):
        """
        Create a new Male.
        """
        super().__init__(mutated_range, genome, strategy, FitnessFunction.get_fitness_function(1))
        self.resource = []

    def signal(self):
        """
        product signal based on own quality and strategy
        """
        quality = self.genome[3]
        return self.strategy.get_response(quality)

    def interact(self, ind: Agent):
        """ male's behavior when encounter a female

        Args:
            ind (Agent): _description_
        """
        if (isinstance(ind, Female)):
            # the encountered individual is a female
            pass
        else:
            raise Exception("interact: male shouldn't be interact with a non-female agent")

class Female(Agent):
    """
    A female of the general population

    Attributes:
    
    """

    def __init__(
        self,
        mlambda,
        genome,
        strategy
    ):
        super().__init__(mlambda, genome, strategy, FitnessFunction.get_fitness_function(0))

    def interact(self, ind):
        pass