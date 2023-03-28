import math

#n1 - decremento compra
#n3 - decremento venda

#n2 - incremento compra
#n4 - incremento venda

def Rmn(k, betamn, tm, tn):
    parc2R = 0
    for i in range(k-1, k):
        parc2R = parc2R + math.exp(-betamn*(tm[k] - tn[i]))
    
    if(k == 0):
        return 0

    return math.exp(-betamn*(tm[k] - tm[k-1]))*Rmn(k-1, betamn, tm, tn) + parc2R

def sumParc2(alfam, betam, t, T):
    parc2 = 0
    for n in range(4):
        parct = 0
        tn = t[n]
        for k in range(tn):
            parct = parct + 1 - math.exp(-betam[n]*(T - tn[k]))
        parc2 = parc2 + alfam[n]/betam[n]*parct
    return parc2

def sumParc3(mum, t, tm, alfam, betam):
    parc3 = 0
    for k in range(tm):
        recparc = 0
        for n in range(4):
            tn = t[n]
            recparc = recparc + alfam[n]*Rmn(k, betam[n], tm, tn)
        parc3 = parc3 + math.log(mum +  recparc)
    return parc3


def func (teta):
    [mu, alfa, beta] = teta
    
    T = 30
    t = [[], [], [], []]    #4 eventos, cada um com seus tk

    res = 0
    for m in range(4):
        tm = t[m]

        parc1 = -mu[m]*T 
        parc2 = -1*sumParc2(alfa[m], beta[m], t, T)
        parc3 = sumParc3(mu[m], t, tm, alfa[m], beta[m])
        
        res = res + parc1 + parc2 + parc3

    return -1*res

#Minimizar func
