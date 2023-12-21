import numpy as np

class Randomizer():
    def __init__(self, seed, for_testing):
        if(seed==-1):
            seed = np.random.randint(1,10000000)
        np.random.seed(seed)
        print("seed: ", seed)
        if (for_testing):
            self.val_li = []
            self.next_val_i = 0
        self.for_testing = for_testing

    def get_seed (self):
        return self.seed

    def get_ran_int(self, lbound: int, ubound: int):
        if(self.for_testing):
            if(self.next_val_i >= len(self.val_li)):
                raise Exception("Error (get_ran_int): Not enough values to test")
            x = self.val_li[self.next_val_i]
            self.next_val_i += 1
        else:
            x = np.random.randint(low = lbound, high=ubound)
        return x
    
    def get_ran_float(self, lbound: float, ubound: float):
        if(self.for_testing):
            if(self.next_val_i >= len(self.val_li)):
                raise Exception("Error (get_ran_float): Not enough values to test")
            x = self.val_li[self.next_val_i]
            self.next_val_i += 1
        else:
            x = np.random.uniform(low = lbound, high=ubound)
        return x
    
    def get_nor_val(self, mean: float, std: float):
        if(self.for_testing):
            if(self.next_val_i >= len(self.val_li)):
                raise Exception("Error (get_nor_val): Not enough values to test")
            x = self.val_li[self.next_val_i]
            self.next_val_i += 1
        else:
            x = np.random.normal(mean, std)
        return x

    def set_test_vals(self, vals_to_output: list):
        if(self.for_testing):
            self.val_li = vals_to_output
        else:
            raise Exception("set_test_vals can only be called when for_testing is enabled")
    
    def end_of_test(self):
        if (self.for_testing):
            if (self.next_val_i != len(self.val_li)):
                raise Exception("Bad test value list")
        else:
            raise Exception("end_of_test can only be called when for_testing is enabled")