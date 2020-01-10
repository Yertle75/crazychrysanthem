#################
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
  m = floor(sqrt(r))+1
  L = dict()
  x = Mod(1,p)
  #storing the giant steps
  for i in range(m+1):
    L[x]=i
    x=x*g
  #doing the baby steps until we find a collision
  u = g^(-m)
  y = h
  for j in range(m+2):
    if L.has_key(y):
      i = L[y]
      break
    y = y*u
  return i+m*j


def pohlig_hellman(N,g,h):
  p=N+1
  g = Mod(g,p)
  h = Mod(h,p)
  factors = list(factor(N))
  reminders = []
  for (f,m) in factors: # loop on factors
    a = 0 #used to store the reminder
    for j in range(1,m+1): # loop on factor multiplicity
      e = N/f^j
      g_ = g^e
      u = g_^(-a)
      h_ = h^e*u
      if h_ != 1:
        e = N/f
        g_ = g^e
        b = BSGS(g_,h_,f^j,p)
        a = a+b*f^(j-1)
    reminders.append(a)
  print CRT(reminders,factors)



def CRT(reminders,factors):
  # at each step, a the final reminder and
  # n (that must be equal to N in the end)
  # are updated with the a_s (reminders mod n_)
  (f, m) = factors.pop()
  n = f^m
  a = reminders.pop()
  while factors != []:
    (f_,k_) = factors.pop()
    n_ = f_^k_
    a_ = reminders.pop()
    (_,m,m_) = xgcd(n,n_)
    a = n*m*a_ + n_*m_*a
    n = n*n_
  a = a%n
  return a

p = 13827821670227353601
g = 3
h = 10780909174164501009

time pohlig_hellman(p-1,g,h)
