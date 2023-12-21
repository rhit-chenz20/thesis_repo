from abc import abstractmethod
import math

class FitnessFunction():
    def get_fitness_function(num):
        if(num == 0):
            return FemaleFitness()
        elif (num == 1):
            return MaleFitness()

    @abstractmethod
    def cal_fitness(self, ind):
        pass

class FemaleFitness(FitnessFunction):
    def cal_fitness(self, female):
        female.fitness = 0

class MaleFitness(FitnessFunction):
    def cal_fitness(self, male):
        male.fitness = 0
