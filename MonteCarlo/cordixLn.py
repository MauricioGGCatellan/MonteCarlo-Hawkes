import math

v0 = math.log(1 + 2**0)
v1 = math.log(1 + 2**-1)
v2 = math.log(1 + 2**-2)
v3 = math.log(1 + 2**-3)
v4 = math.log(1 + 2**-4)
v5 = math.log(1 + 2**-5)
v6 = math.log(1 + 2**-6)
v7 = math.log(1 + 2**-7)

v = [v0, v1, v2, v3, v4, v5, v6, v7]

x0 = 0.65            #Range possível de x0: 0.5 <= x0 <= 1
x = x0
y = 0

for i in range(4):
    D = x*(1 + 2**(-1*i))
    if(D<=1):
        x = x*(1+ 2**(-1*i))
        y = y - v[i]

print("Ln de ", x0, ": ", y)
print(x)        
    
    
