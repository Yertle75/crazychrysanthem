
#Babystep-Giantstep 
def BSGS(g,h,r,p):
  m = floor(sqrt(r))+1
  L = dict()
  x = Mod(1,p)
  for i in range(m+1):
    L[x]=i
    x=x*g
  u = Mod(g^(-m),p)
  y = Mod(h,p)
  for j in range(m+2):
    if L.has_key(y):
      break
    y = y*u
  if j== m+1:
    print("fail") # happens sometimes if g is not a generator of Z/pZ
    return -1
  return i+m*j

def pohlig_hellman2(N,g,h):
  p=N+1
  factors = factor(N)
  reminders = []
  for (f,m) in factors: # loop on factors
    a = 0
    for j in range(1,m+1): # loop on factor multiplicity
      e = N/f^j
      g_ = Mod(g,p)
      h_ = Mod(h,p)
      g_ = g_^e
      h_ = h_^e
      u = Mod(g_^(-a),p)
      h_ = h_*u
      if h_ != 1:
        e = N/f
        g_ = Mod(g,p)
        g_ = g_^e
        b = 1
        BSGS(g_,h_,f^j,p)
        a = a+b*f^(j-1)
    reminders.append(a)
  CRT(reminders,factors)

def pohlig_hellman(N,g,h):
  p=N+1
  factors = factor(N)
  reminders = []
  for (f,m) in factors: # loop on factors
    a = 0
    for j in range(1,m+1): # loop on factor multiplicity
      e = N/f^j
      g_ = Mod(g,p)
      h_ = Mod(h,p)
      g_ = g_^e
      h_ = h_^e
      u = Mod(g_^(-a),p)
      h_ = h_*u
      if h_ != 1:
        e = N/f
        g_ = Mod(g,p)
        g_ = g_^e
        b = 1
        T = g_
        while h_ != T: #exhaustive search (to be improved)
          b = b+1
          T = T*g_
        a = a+b*f^(j-1)
    reminders.append(a)
  CRT(reminders,factors)

def CRT(reminders,factors):
  factors = list(factors)
  (f_0, m_0) = factors.pop()
  n_0 = f_0^m_0
  a_0 = reminders.pop()
  while factors != []:
    (f_1,m_1) = factors.pop()
    n_1 = f_1^m_1
    a_1 = reminders.pop()
    (_,m_0,m_1) = xgcd(n_0,n_1)
    big_reminder = n_0*m_0*a_1 + n_1*m_1*a_0
    big_modulo = n_0*n_1
    (n_0,a_0) = (big_modulo,big_reminder)
  if reminders != []:
    print("there was an error, the list reminder is not empty!")
  a_0 = a_0%n_0
  print(a_0,n_0)

###tests
#reminders = [2,3,2]
#factors = [(3,1),(5,1),(7,1)]
#CRT(reminders,factors)
###
p = 13827821670227353601
g = 3
h = 10780909174164501009
time pohlig_hellman2(p-1,g,h)
