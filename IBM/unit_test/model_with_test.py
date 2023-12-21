
def assertEqual():pass
generation = 1
population = 0
class Population():
    pass

def code_that_runs_every_generation():
    """
    Some codes that are part of the model
    """
    
    # Tests that only runs at a specific generation
    if (generation == 1000):
        assertEqual(population.size, 4100)
    
    if(generation == 2000):
        assertEqual(population.size, 2000)
        

def unit_test_population():
    population_under_test = Population()
    population_under_test.set_size(2000)
    assertEqual(population.size, 2000)
    