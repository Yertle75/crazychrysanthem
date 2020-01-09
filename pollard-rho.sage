import numpy as np

def f_default(x):
  return x^2+1

###############
## Pollard-rho algorithm with 2 flavors:
#   * With Floyd cycle finding
#   * With Brent cycle finding
##############

# Vanilla pollard-rho with Floyd cycle finding 

def pollard_rho(N,f=f_default,batch_size=1):
  factor = 1
  x = mod(0,N)
  y = mod(f(x),N)
  b=0 			#this var is the counter that tells us when to compute the gcd of the batch
  batch = mod(1,N) 	#this var is used to store the successive (x-y)s
  while (factor==1) :
    x = f(x)
    y = f(f(y))
    batch *= (x-y)
    b += 1
    if b == batch_size:   #compute batch-gcd
      factor = gcd(batch,N)
      b = 0
  print factor

# Pollard-rho with Brend cycle finding    
def pollard_rho2(N,f=f_default,batch_size=1):
  factor = 1
  x = mod(0,N)
  y = mod(f(x),N)
  j = 1
  b = 0
  while (factor==1) :
    x = y
    batch = mod(1,N)
    for i in range(2^j):
      y = f(y)
      batch *= (x-y)
      b += 1
      if b == batch_size:
        factor = gcd(batch,N)
        b = 0
        if factor!=1 :
          break
    j += 1
  print factor

N1 = 60331193824455101058028269521753
N2 = 276474933387964773460419532857385928669681
N3 = 3827821670227353601
time pollard_rho2(N2,batch_size=1000)


