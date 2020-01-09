##########
#
#   p+1 algorithm 
#
#   I use a 'trick' to avoid recoding the operation *
#   Just like a+ib is equivalent to the matrix :
#   a  b
#   -b a
#   Our pair a+sqrt(d)b can be written:
#   a  b
#   db a
#   and we get the multiplication for free since
#   a  b  *  a'  b' = aa'+dbb'   ab'+a'b
#   db a     db' a'   d(a'b+ab') dbb'+aa'
#
##########


import numpy as np

def pplusone(N,B):
    X = np.prod([p^floor(log(B)/log(p)) for p in primes(1,B)])
    factor = 1
    while(factor == 1):
      a = Mod(randint(1,N-1),N)
      b = Mod(randint(1,N-1),N)
      d = (a^2-1)/b^2
      alpha = matrix([[a,b],[d*b,a]])
      (u,v) = (alpha^X)[0]
      factor = gcd(u-1,v)
    print(factor)

time pplusone(95853544864250299111409,2101)
