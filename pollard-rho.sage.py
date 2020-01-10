
# This file was *autogenerated* from the file pollard-rho.sage
from sage.all_cmdline import *   # import sage library

_sage_const_2 = Integer(2); _sage_const_1 = Integer(1); _sage_const_0 = Integer(0); _sage_const_60331193824455101058028269521753 = Integer(60331193824455101058028269521753); _sage_const_276474933387964773460419532857385928669681 = Integer(276474933387964773460419532857385928669681); _sage_const_13 = Integer(13); _sage_const_17 = Integer(17); _sage_const_3827821670227353601 = Integer(3827821670227353601)
import numpy as np

def default_f(x):
  return x**_sage_const_2 +_sage_const_1 

###############
## Pollard-rho algorithm with 2 flavors:
#   * With Floyd cycle finding
#   * With Brent cycle finding
##############

# Vanilla pollard-rho with Floyd cycle finding 

def pollard_rho(N,f=default_f,batch_size=_sage_const_1 ):
  factor = _sage_const_1 
  x = mod(_sage_const_0 ,N)
  y = mod(f(x),N)
  b=_sage_const_0  			#this var is the counter that tells us when to compute the gcd of the batch
  batch = mod(_sage_const_1 ,N) 	#this var is used to store the successive (x-y)s
  while (factor==_sage_const_1 ) :
    x = f(x)
    y = f(f(y))
    batch *= (x-y)
    b += _sage_const_1 
    if b == batch_size:   #compute batch-gcd
      factor = gcd(batch,N)
      batch = mod(_sage_const_1 ,N)
      b = _sage_const_0 
  print factor

# Pollard-rho with Brend cycle finding    
def pollard_rho2(N,f=default_f,batch_size=_sage_const_1 ):
  factor = _sage_const_1 
  x = mod(_sage_const_0 ,N)
  y = mod(f(x),N)
  k = _sage_const_1  # to iterate on cycles of size 2^k
  b = _sage_const_0 
  while (factor==_sage_const_1 ) :
    x = y
    batch = mod(_sage_const_1 ,N)
    for i in range(_sage_const_2 **k):
      y = f(y)
      batch *= (x-y)
      b += _sage_const_1 
      if b == batch_size:
        factor = gcd(batch,N)
        b = _sage_const_0 
        if factor!=_sage_const_1  :
          break
    k += _sage_const_1 
  print factor

N1 = _sage_const_60331193824455101058028269521753 
N2 = _sage_const_276474933387964773460419532857385928669681 
N3 = _sage_const_3827821670227353601 

__time__=misc.cputime(); __wall__=misc.walltime(); pollard_rho2(_sage_const_17 *_sage_const_13 ,batch_size=_sage_const_1 ); print("Time: CPU %.2f s, Wall: %.2f s"%(misc.cputime(__time__), misc.walltime(__wall__)))
__time__=misc.cputime(); __wall__=misc.walltime(); pollard_rho2(_sage_const_17 *_sage_const_13 ,batch_size=_sage_const_1 ); print("Time: CPU %.2f s, Wall: %.2f s"%(misc.cputime(__time__), misc.walltime(__wall__)))


