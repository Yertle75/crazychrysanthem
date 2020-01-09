

def BSGS(g,h,N):
  p = N+1
  g = Mod(g,p)
  h = Mod(h,p)
  m = floor(sqrt(N))+1
  L = dict()
  x = Mod(1,p)
  for i in range(m):
    L[x]=i
    x=x*g
  u = g^(-m)
  y = h
  for j in range(m+2):
    if L.has_key(y):
      i = L[y]
      break
    y = y*u
  if j== m+1:
    print("fail g was not a generator!")
    return
  print(i,m,j)



BSGS(2,8,16)
BSGS(2,10,22)
