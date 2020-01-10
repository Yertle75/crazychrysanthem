
# This file was *autogenerated* from the file pohlig-hellman.sage
from sage.all_cmdline import *   # import sage library

_sage_const_3 = Integer(3); _sage_const_2 = Integer(2); _sage_const_1 = Integer(1); _sage_const_0 = Integer(0); _sage_const_81 = Integer(81); _sage_const_11 = Integer(11); _sage_const_17 = Integer(17)#################
# /!\ I didn't implement any safeguards in case
# the g provided is not a generator...
# anything from error to wrong answer can happen /!\
#################"


#Babystep-Giantstep 
def BSGS(g,h,r,p):
  # g generates a subgroup of Z/pZ of order r
  # we look for b s.t. g^b=h
  g = Mod(g,p)
  h = Mod(h,p)
  m = floor(sqrt(r))+_sage_const_1 
  L = dict()
  x = Mod(_sage_const_1 ,p)
  #storing the giant steps
  for i in range(m+_sage_const_1 ):
    L[x]=i
    x=x*g
  #doing the baby steps until we find a collision
  u = g**(-m)
  y = h
  for j in range(m+_sage_const_2 ):
    if L.has_key(y):
      i = L[y]
      break
    y = y*u
  return i+m*j

#naive exhaustive search 
def exhaustive_search(g_,h_):
        b = _sage_const_1 
        T = g_
        while h_ != T: #exhaustive search (to be improved)
          b = b+_sage_const_1 
          T = T*g_
        return b


def pohlig_hellman(N,g,h):
  p=N+_sage_const_1 
  g = Mod(g,p)
  h = Mod(h,p)
  factors = list(factor(N))
  reminders = []
  for (f,m) in factors: # loop on factors
    a = _sage_const_0  #used to store the reminder
    for j in range(_sage_const_1 ,m+_sage_const_1 ): # loop on factor multiplicity
      e = N/f**j
      g_ = g**e
      u = g_**(-a)
      h_ = h**e*u
      if h_ != _sage_const_1 :
        e = N/f
        g_ = g**e
        b = BSGS(g_,h_,f**j,p)
        a = a+b*f**(j-_sage_const_1 )
    reminders.append(a)
  print CRT(reminders,factors)



def CRT(reminders,factors):
  # at each step, a the final reminder and
  # n (that must be equal to N in the end)
  # are updated with the a_s (reminders mod n_)
  (f, m) = factors.pop()
  n = f**m
  a = reminders.pop()
  while factors != []:
    (f_,k_) = factors.pop()
    n_ = f_**k_
    a_ = reminders.pop()
    (_,m,m_) = xgcd(n,n_)
    a = n*m*a_ + n_*m_*a
    n = n*n_
  a = a%n
  return a

#p = 13827821670227353601
#g = 3
#h = 10780909174164501009

g = _sage_const_3 
h = _sage_const_81 
p = _sage_const_11 *_sage_const_17 

__time__=misc.cputime(); __wall__=misc.walltime(); pohlig_hellman(p-_sage_const_1 ,g,h); print("Time: CPU %.2f s, Wall: %.2f s"%(misc.cputime(__time__), misc.walltime(__wall__)))

