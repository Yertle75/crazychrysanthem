import numpy as np

def default_f(x):
  return x^2+1

###############
## Pollard-rho algorithm with 2 flavors:
#   * With Floyd cycle finding
#   * With Brent cycle finding
##############

# Vanilla pollard-rho with Floyd cycle finding 

def pollard_rho(N,f=default_f,batch_size=1):
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
      batch = mod(1,N)
      b = 0
  print factor

# Pollard-rho with Brend cycle finding    
def pollard_rho2(N,f=default_f,batch_size=1):
  factor = 1
  x = mod(0,N)
  y = mod(f(x),N)
  k = 1 # to iterate on cycles of size 2^k
  b = 0
  while (factor==1) :
    x = y
    batch = mod(1,N)
    for i in range(2^k):
      y = f(y)
      batch *= (x-y)
      b += 1
      if b == batch_size:
        factor = gcd(batch,N)
        b = 0
        if factor!=1 :
          break
    k += 1
  print factor

# woudn't advise you to run the algo on them (1+min ...and above )
N1 = 60331193824455101058028269521753
N2 = 276474933387964773460419532857385928669681
# answers in less than 1min
N3 = 3827821670227353601
dumb_N = 11*17

time pollard_rho2(dumb_N,batch_size=1)
time pollard_rho2(dumb_N,batch_size=1)

