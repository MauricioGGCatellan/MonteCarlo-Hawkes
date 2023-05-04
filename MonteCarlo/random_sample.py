import math
import random

#Retorna valor de autoexcitação
def app_function(mi, beta, X, s, k=4):
    lambda_bar = 0

    for i in range(k):
        lambda_bar = lambda_bar + mi[i]
        for j in range(k):
            lambda_bar = lambda_bar + math.exp(-1*beta[i][j]*s)*X[i][j]

    return lambda_bar

#Função utilizada na amostragem do s (pulo aleatório)
def inverse_transform_sampling(lambda_bar):
    u = random.randint(1, 65536)/65536
    
    w = -1*math.log(u)/lambda_bar
    return w

#Função utilizada na amostragem de k (evento aleatório dentre os 4 possíveis)
def acceptance_rejection_sampling(lambda_bar, mi, beta, X, s):
    D = random.randint(1, 65536)/65536

    if(D*lambda_bar <= app_function(mi, beta, X, s)):
        k = 1

        while(D*lambda_bar > app_function(mi, beta, X, s, k)):
            k = k + 1
        return k
    else:
        return -1

