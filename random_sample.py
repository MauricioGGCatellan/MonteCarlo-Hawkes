from random_number import Fibbonacci_LFSR_Rand
from event_generator import app_function
import math

start_state = 30 
M = 4

def inverse_transform_sampling(lambda_bar):
    
    u = Fibbonacci_LFSR_Rand(start_state)/65536
    w = -1*math.log(u)/lambda_bar
    return w

def acceptance_rejection_sampling(lambda_bar, mi, beta, X, s):
    D = Fibbonacci_LFSR_Rand(start_state)/65536

    if(D*lambda_bar <= app_function(mi, beta, X, s)):
        k = 1

        while(D*lambda_bar > app_function(mi, beta, X, s, k)):
            k = k + 1
        return k
    else:
        return -1

