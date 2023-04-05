import math

v0 = -math.inf
v1 = math.log(1 - 2**-1)
v2 = math.log(1 - 2**-2)
v3 = math.log(1 - 2**-3)
v4 = math.log(1 - 2**-4)
v5 = math.log(1 - 2**-5)
v6 = math.log(1 - 2**-6)
v7 = math.log(1 - 2**-7)

v = [v0, v1, v2, v3, v4, v5, v6, v7]

x0 = 0 #Range de x0: -1.24 a 0
x = x0 
y = 1

for i in range(8):
    D = x - v[i]
    if(D <= 0):
        x = D
        y = y*(1 - 2**-i)
    

print(x)  #x final: ~0
print(y)  #y final: e**x0