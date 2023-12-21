from abc import abstractmethod

class Strategy():
    def __init__(
        self
    ):
        """
        Create a new Female.
        """
    
    @abstractmethod
    def get_response(self, quality: float):
        pass
    
class FemaleCaution(Strategy):
    def __init__(
        self
    ):
        """
        Create a new Female.
        """
        super.__init__()
    
    @abstractmethod
    def get_response(self, quality: float):
        pass
    
class FemalePosLin(Strategy):
    def __init__(
        self
    ):
        """
        Create a new Female.
        """
        super.__init__()
    
    @abstractmethod
    def get_response(self, quality: float):
        pass
    
class FemaleNegLin(Strategy):
    def __init__(
        self
    ):
        """
        Create a new Female.
        """
        super.__init__()
    
    @abstractmethod
    def get_response(self, quality: float):
        pass
    
class MaleHonestStra(Strategy):
    def __init__(
        self
    ):
        """
        Create a new Female.
        """
        super.__init__()
    
    @abstractmethod
    def get_response(self, quality: float):
        pass
    
class MaleAllLie(Strategy):
    def __init__(
        self
    ):
        """
        Create a new Female.
        """
        super.__init__()
    
    @abstractmethod
    def get_response(self, quality: float):
        pass
    
class MaleWorseLieMore(Strategy):
    def __init__(
        self
    ):
        """
        Create a new Female.
        """
        super.__init__()
    
    @abstractmethod
    def get_response(self, quality: float):
        pass
    
class MaleCostly(Strategy):
    def __init__(
        self
    ):
        """
        Create a new Female.
        """
        super.__init__()
    
    @abstractmethod
    def get_response(self, quality: float):
        pass