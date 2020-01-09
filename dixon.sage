
def dixon(N,B):
    P = list(primes(1,B)) #create the prime basis
    k = len(P)
    M = Matrix(k+1,k,sparse=True)
    Z = vector(range(k+1))
    for i in range(k+1):
        z,z2_factors = draw_Bsmooth(B,N)
        Z[i]=z
        (f,m) = z2_factors.pop()
        for j in reversed(range(k)):
            if P[j] == f :
              M[i,j] = m
              try :
                (f,m) = z2_factors.pop()
              except :
                break
    print("we found enough relations")
    #now extract a fermat factorization
    v = []
    for j in range(k):
        for i in range(k+1):
            if odd(M[i,j]):
                for l in range(i+1,k+1):
                    if odd(M[l,j]):
                        M[l]+=M[i]
                M[i]=0
                v.append(i)
                break
    print("now find the first square")
    gud_i = -1
    for i in range(k+1):
        if M[i] != 0: #we used this line for some reduction
            gud_i=i
            break
    print("we found a gud_i")
    r1 = Mod(1,N)
    r2 = Mod(1,N)
    #print("v",v)
    #print("M",M)
    #print("Z",Z)
    for x in v:
        if x > gud_i:
            break
        r1*= Z[x]
    for j in range(k):
        try:
          r2*= Mod(P[j],N)^(M[gud_i,j]/2) 
        except:
          print("error r2 ->",r2,M[gud_i,j])
    #print("P",P)
    #print("gud i",gud_i)
    return gcd(r1+r2,N)

def odd(x):
    return x%2==1

def draw_Bsmooth(B,N):
    while True:
        z = Mod(randint(floor(sqrt(N))+1,N-1),N) #pick a square
        #dev note: replace this with proper basis search
        if z^2 == 1 or z^2 == 0:
            continue
        z2_factors = list(factor(int(z^2)))
        if z^2 != 0 and z2_factors[-1][0]<= B : # then z2 is B-smooth
           return z,z2_factors
while True:
   N = 8591966237
   r = dixon(N,floor(exp(sqrt(log(N)*log(log(N))))))
   if r != 1:
       print("r ",r)
       break
   print("failed")
