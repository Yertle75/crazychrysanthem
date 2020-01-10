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
import time
def pplusone(N,B):
    X = reduce(lambda x,y : x*y, [p^(floor(log(B)/log(p))+1) for p in primes(1,B)])
    factor = 1
    while(factor == 1):
      a = Mod(randint(1,N-1),N)
      b = Mod(randint(1,N-1),N)
      d = (a^2-1)/b^2
      alpha = matrix([[a,b],[d*b,a]])
      (u,v) = (alpha^X)[0]
      factor = gcd(u-1,v)
    print(factor)


N,B = 17*13,100
N,B = 8591966237, 100
N,B = 95853544864250299111409,2100
# Note, you need to tweek the code a bit for this one to work
# (plug 40000000000 instead of the exponend in the computation of X)
#N,B = 746482824012238308661619491135773503333385064366762059957618554835738449567418578817253229,1000
time pplusone(N,B)
