from random_sample import inverse_transform_sampling, acceptance_rejection_sampling
import math

#mi, alfa e beta: não sei qual usar (obs: são compostos por nros positivos). Seguem a regra:
#μm > 0, αmn ≥ 0, βmn ≥ 0, ρ(Γ) < 1, Γ = {alfa/beta}mxn


#X: utilizar zerado.

#qa, qb,sbM, saM, sbL, saL: pegar do arquivo do trab do amigo

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

def monte_carlo_mean_price(qa, qb,sbM, saM, sbL, saL, mi, alfa, beta, Xt, N):
    y = 0
    Qa, Qb = []

    for _ in range(1, N):
        Qa[0] = qa
        Qb[0] = qb
        X = Xt
        t = 0
        while(Qa > 0 and Qb > 0):
            [s,k] = event_generator(mi, beta, X)
            if(k == 1):
                Qb[t + s] = Qb[t] - sbM
            elif(k == 2):
                Qb[t + s] = Qb[t] + sbL
            elif(k == 3):
                Qa[t + s] = Qa[t] - saM
            else:
                Qa[t + s] = Qa[t] + saL
            for m in range(1, 4):
                for n in range(1, 4):
                    X[m][n] = X[m][n] * math.exp(-beta[m][n]-s)
                if(k == n):
                    X[m][n] =  X[m][n] + alfa[m][n]
            
            t = t + s
        if(Qa[t] <= 0):
            y = y + 1
    
    return y/N

mi = [0.08, 0.08, 0.05, 0.05]
alfa = [[0 , 0.4, 0, 0],[0.4, 0,0,0],[0,0, 0.5, 0.3],[0,0,0.3,0.5]]
beta= [[0.6,0.6,0.6,0.6],[0.6,0.6,0.6,0.6],[1.2,1.2,1.2,1.2],[1.2,1.2,1.2,1.2]]
X = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]] 

#Qa e Qb: volumes de ask e bid no instante observado.
#sbM, saM, sbL, saL: valores que não sei como obter :(