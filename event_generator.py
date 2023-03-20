from random_sample import inverse_transform_sampling, acceptance_rejection_sampling
import math

#mi = [1,2,3,4]
beta= [[1,1,1,1],[2,2,2,2],[3,3,3,3],[4,4,4,4]]
X = [[1,1,1,1],[2,2,2,2],[3,3,3,3],[4,4,4,4]] 

def app_function(mi, beta, X, s, k=4):
    #faz uma conta que retorna lambda_bar
    lambda_bar = 0

    for i in range(k):
        lambda_bar = lambda_bar + mi[i]
        for j in range(k):
            lambda_bar = lambda_bar + math.exp(-beta[i][j]*s)*X[i][j]

    return lambda_bar


def event_generator(mi, beta, X):
    s = 0

    while True:
        lambda_bar = app_function(mi, beta, X, s)

        w = inverse_transform_sampling(lambda_bar, s)
        s = s + w
        k = acceptance_rejection_sampling(lambda_bar, mi, beta, X, s)
        if(k >= 0):
            return [s, k]


