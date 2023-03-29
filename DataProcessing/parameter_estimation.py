import math

#n1 - decremento compra
#n3 - decremento venda

#n2 - incremento compra
#n4 - incremento venda

def Rmn(k, betamn, tm, tn):
    parc2R = 0
    i = 0

    for index, t in enumerate(tn):
        if(t >= tm[k-1]):
            i = index
            break

    while(i < len(tn) and tn[i] >= tm[k-1] and tn[i] < tm[k]):
        parc2R = parc2R + math.exp(-betamn*(tm[k] - tn[i]))
        i = i + 1
    
    if(k == 0):
        return 0

    return math.exp(-betamn*(tm[k] - tm[k-1]))*Rmn(k-1, betamn, tm, tn) + parc2R

def sumParc2(alfam, betam, t, T):
    parc2 = 0
    for n in range(4):
        parct = 0
        tn = t[n]
        for k in range(len(tn)):
            parct = parct + 1 - math.exp(-betam[n]*(T - tn[k]))
        parc2 = parc2 + alfam[n]/betam[n]*parct
    return parc2

def sumParc3(mum, t, tm, alfam, betam):
    parc3 = 0
    for k in range(len(tm)):
        recparc = 0
        for n in range(4):
            tn = t[n]
            recparc = recparc + alfam[n]*Rmn(k, betam[n], tm, tn)
        parc3 = parc3 + math.log(mum +  recparc)
    return parc3


def func (teta):
    [mu, alfa, beta] = teta
    
    #Baseado em limitorderbook_process.py
    T = 60                  
    t = [[1, 3, 5, 7, 9, 10, 11, 12, 14, 15, 18, 19, 20, 21, 22, 23, 24, 25, 27, 29, 32, 33, 35, 38, 40, 41,    #Descida Bid
           43, 44, 45, 46, 47, 48, 49, 50, 52, 53, 54, 56, 57, 58, 59],
            [2, 4, 6, 8, 13, 16, 17, 26, 28, 30, 31, 34, 36, 37, 39, 42, 51, 55],                             #Subida Bid
        [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 15, 16, 17, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30,    #Descida Ask
          31, 32, 33, 35, 37, 39, 40, 41, 42, 44, 45, 46, 47, 48, 49, 50, 51, 52, 54, 55, 56, 58, 59],
          [11, 14, 18, 34, 36, 38, 43, 53, 57]]                                                               #Subida Ask
                                                                                                             
    res = 0
    for m in range(4):
        tm = t[m]

        parc1 = -1*mu[m]*T 
        parc2 = -1*sumParc2(alfa[m], beta[m], t, T)
        parc3 = sumParc3(mu[m], t, tm, alfa[m], beta[m])
        
        res = res + parc1 + parc2 + parc3

    return -1*res


#Valores de teste
mu = [0.08, 0.08, 0.05, 0.05]
alfa = [[0 , 0.4, 0, 0],[0.4, 0,0,0],[0,0, 0.5, 0.3],[0,0,0.3,0.5]]
beta= [[0.6,0.6,0.6,0.6],[0.6,0.6,0.6,0.6],[1.2,1.2,1.2,1.2],[1.2,1.2,1.2,1.2]]

print(func([mu, alfa, beta]))

#Minimizar func