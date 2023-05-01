import random
import numpy as np
b1=0x5091
b2=0x67E2
b3=0xA083
b4=0x69D3
b5=0x21E2
b6=0x98F9
b7=0xC74C
b8=0x0C00
b9=0x751F
b10=0x7702
b11=0xA85A
b12=0x7878
b13=0x7508
b14=0xFC42
b15=0x4CDF
b16=0xA453
Breg=[b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16]
#0.05 = 0.0000 0011 0011 0011
count=0
size=(16 , 50)
mX = np.zeros(size)
xreg=[]
xreg_nxt=[]
#print(hex(Breg[3]<<16)," ",hex(Breg[3]))
for i in range (16):
   xreg.append(random.getrandbits(32))
   xreg_nxt.append(0x0)
for j in range(50):
  for i in range (16):
   arm_p1 = xreg[i+1] if i<15 else 0
   arm_p2 = xreg[i+2] if i<14 else 0
   arm_p3 = xreg[i+3] if i<13 else 0
   arm_m1 = xreg_nxt[i-1] if i>0 else 0
   arm_m2 = xreg_nxt[i-2] if i>1 else 0
   arm_m3 = xreg_nxt[i-3] if i>2 else 0
   xreg_nxt[i] = 0x333 * ((Breg[i]<<16)+13*(arm_p1 + arm_m1 ) - 6*(arm_m2 + arm_p2) + (arm_m3  + arm_p3))
   xreg_nxt[i] = xreg_nxt[i] >>16
  for i in range(16):
       xreg[i] = xreg_nxt[i]

for mi in range(16):
  print(hex(xreg_nxt[mi]))




