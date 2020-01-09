

def BSGS(g,h,r):
  p = r+1
  g = Mod(g,p)
  h = Mod(h,p)
  m = floor(sqrt(r))+1
  L = dict()
  x = Mod(1,p)
  for i in range(m):
    L[x]=i
    x=x*g
  u = g^(-m)
  y = h
  for j in range(m+2):
    if L.has_key(y):
      break
    y = y*u
  if j== m+1:
    print("fail")
    return
  print(i+m*j)



BSGS(2,8,16)
BSGS(2,10,22)
