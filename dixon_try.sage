
def dixon(N,B):
    P = list(primes(1,B)) #create the prime basis
    k = len(P)
    Z2 = Integers(2)
    M = Matrix(Z2,k+1,k,sparse=True)
    Z = vector(range(k+1))
    print("finding relations")
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
    #now extract a fermat factorization
    print("extracting kernel")
    basis = M.kernel().basis()
    print("finding factor")
    for e in basis:
        a = Mod(1,N)
        for i in range(len(e)):
            if e[i] == 1:
                a*=Z[i]
        b = sqrt(a^2)
        d=gcd(a+b,N)
        if d != 1 and d != N:
            print("a factor was found: "+str(d))
            return
    print("failed, no factor was found")

def draw_Bsmooth(B,N):
    while True:
        z = Mod(randint(floor(sqrt(N))+1,N-1),N) #pick a square
        #dev note: replace this with proper basis search
        if z^2 == 1 or z^2 == 0:
            continue
        z2_factors = list(factor(int(z^2)))
        if z2_factors[-1][0]<= B : # then z2 is B-smooth
           return z,z2_factors

N = 17*19
N = 65537*131101
N = 33554467*67108879
#N = 73786976659910426999
dixon(N,floor(exp(sqrt(log(N)*log(log(N))))))
