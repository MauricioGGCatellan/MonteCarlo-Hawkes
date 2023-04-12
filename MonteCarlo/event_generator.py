from random_sample import inverse_transform_sampling, acceptance_rejection_sampling, app_function
import math

def event_generator(mi, beta, X):
    s = 0

    while True:
        lambda_bar = app_function(mi, beta, X, s)

        w = inverse_transform_sampling(lambda_bar)
        s = s + w
        k = acceptance_rejection_sampling(lambda_bar, mi, beta, X, s)
        if(k >= 1):
            return [s, k]

def monte_carlo_mean_price(qa, qb,sbM, saM, sbL, saL, mi, alfa, beta, Xt, N):
    y = 0
    
    for _ in range(1, N):
        Qa = [qa]
        Qb = [qb]
        X = Xt
        t = [0]
        while(Qa[-1] > 0 and Qb[-1] > 0):
            [s,k] = event_generator(mi, beta, X)
            if(k == 1):
                Qb.append(Qb[-1] - sbM)  
            elif(k == 2):
                Qb.append(Qb[-1] + sbL) 
            elif(k == 3):
                Qa.append(Qa[-1] - saM)
            else:
                Qa.append(Qa[-1] + saL)
            for m in range(1, 4):
                for n in range(1, 4):
                    X[m][n] = X[m][n] * math.exp(-beta[m][n]-s)
                if(k == n):
                    X[m][n] =  X[m][n] + alfa[m][n]
            
            t.append(t[-1] + s)
        if(Qa[-1] <= 0):
            y = y + 1
    
    return y/N

#Valores obtidos de parameter_estimation.py
mi = [0.683, 0.300, 0.833, 0.145]
alfa = [[0 , 0, 0, 0],[0, 0,0,0],[0,0,0,0],[0,0,0,0]]
beta= [[0.827,0.661,0.849,0.608],[0.700,0.6,0.6,0.6],[1.2,1.2,1.184,1.192],[1.2,1.2,1.235,1.287]]
X = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]       #Estado inicial nulo
###

#Valores obtidos de libitorderbook_process.py
saL = 0.001951
saM = 0.000351
sbL = 0.002775
sbM = 0.001292
###

#Últimos volumes da janela de tempo considerada em parameter_estimation.py
qa = 0.00200
qb = 0.00178
###

N = 1000

probUp = monte_carlo_mean_price(qa, qb, sbM, saM, sbL, saL, mi, alfa, beta, X, N)

print(probUp*100, "%")      