
def dixon(N,B):
    P = list(primes(1,B)) #create the prime basis
    k = len(P)
    Z2 = Integers(2)
    M = Matrix(Z2,k+1,k,sparse=True)
    Z = vector(range(k+1))
    print("finding relations")
    for i in range(k+1):
        z,z2_factors = draw_Bsmooth(P,N)
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
            print d
            return
    print("failed, no factor was found")

def check_prime(n,P):
  for p in P:
     while n%p == 0:
       n = n/p
       if n == 1:
         return True
  return False

def draw_Bsmooth(P,N):
    while True:
        z = Mod(randint(floor(sqrt(N))+1,N-1),N) #pick a square
        s = int(z^2) 
        if s == 1 or s == 0 or not(check_prime(s,P)):
            continue
        # since we know the factors are small calling the function factor
        # is not such a big "arnaque".
        # I just use this trick to keep the code as short and readable
        # as possible
        z2_factors = list(factor(s))
        return z,z2_factors

N =8591966237
#N = 2251802665812493
#N = 73786976659910426999

time dixon(N,100)
