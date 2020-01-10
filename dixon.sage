####################
#
#   Dixon Algorithm
#
####################

def dixon2(N,B):
    P = list(primes(1,B)) #create the prime basis
    k = len(P)
    # We build the matrix mod 2 to store the decomposition in basis P
    M = Matrix(Integers(2),k+1,k,sparse=True)
    # This vector stores the B_smooth integers found 
    Z = vector(range(k+1))
    print("finding relations")
    # we iterate on z close to sqrt(N) to find z2 Bsmooth
    i = 0 #nb of relations found
    z = floor(sqrt(N))
    while i!=k+1:
        z+=1
        z2 = z^2%N
        Bsmooth,z2_factors = is_Bsmooth(z2,P)
        if not(Bsmooth):
            continue
        Z[i]=z
        (f,m) = z2_factors.pop()
        for j in reversed(range(k)):
            if P[j] == f :
              M[i,j] = m
              try :
                (f,m) = z2_factors.pop()
              except :
                break
        i+=1
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

def is_Bsmooth(n,P):
  factors = []
  for p in P:
     m = 0 #multiplicity
     while n%p == 0:
       n = n/p
       m +=1
       if n == 1:
         factors.append((p,m))
         return True,factors
     factors.append((p,m))
  return False,factors
        
N,B =8591966237,100
#N,B = 2251802665812493,1000
#N,B = 73786976659910426999,3000

time dixon2(N,B)
