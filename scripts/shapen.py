#!/usr/bin/python
from PIL import Image
import numpy as np
#im = Image.open('Bulldog.jpg', 'r')
im = Image.open('halcon.jpg', 'r')

Imag = list(im.getdata())

width, height = im.size
"""
H = [[1 ,-1, 1],[-1, 1,-1],[1 ,-1, 1]]
"""



#boxblur
Hbb,Hsbb = ([[1,2,1],[2,4,2],[1,2,1]],16)

#blur
Hb,Hsb = ([[1,1,1],[1,1,1],[1,1,1]],9)




#sharpening
Hs,Hss = ([[0 ,-1, 0],[-1, 5,-1],[0 ,-1, 0]],1)

#over-sharpening
Hos,Hsos = ([[-1,-1,-1],[-1, 9,-1],[-1 ,-1, -1]],1)


new_image = []

I = []


for i in range(0,height):
    row = []
    for j in range(0,width):
        #print(Imag[width*i+j])
        r,g,b = Imag[width*i+j]
        gray = int((r+g+b)/3)
        row.append(Imag[width*i+j][0:3])#int((r+g+b)/3))
        #row.append((gray,gray,gray))
    I.append(row)

def sharpen(I,Hs,H,h,w,ini,flag = True):
    F = []
    for y in range(ini,(h-ini)):
        row = []
        for x in range(ini,(w-ini)):
            IpR = 0
            IpG = 0
            IpB = 0
            for j in range(0,3):
                for i in range(0, 3):
                    R = I[y-i][x-j][0]
                    G = I[y-i][x-j][1]
                    B = I[y-i][x-j][2]
                    IpR += H[j][i]*R
                    IpG += H[j][i]*G
                    IpB += H[j][i]*B
            if flag: 
                if IpR > 255:
                    IpR = 255
                elif IpR < 0:
                    IpR = 0
                if IpG > 255:
                    IpG = 255
                elif IpG < 0:
                    IpG = 0
                if IpB > 255:
                    IpB = 255
                elif IpB < 0:
                    IpB = 0
            row.append( (int(IpR/Hs),int(IpG/Hs),int(IpB/Hs)) )
            #row.append( (int(IpR/Hs)%255,int(IpG/Hs)%255,int(IpB/Hs)%255) )
            #I[y][x] = (int(IpR/Hs)%255,int(IpG/Hs)%255,int(IpB/Hs)%255)
        F.append(row)
    return F

#new_image = sharpen(I,Hs,H, height,width,2)
F = sharpen(I,Hss,Hs, height,width,2)
new_image = sharpen(I,Hsos,Hos, height-4,width-4,0)
B = sharpen(I,Hsb,Hb, height,width,2,False)


#ToShow = Image.fromarray(np.asarray(new_image).astype(np.uint8),mode="L")
#ToShow = Image.fromarray(np.asarray(new_image).astype(np.uint8),mode="RGB")
ToShowA = Image.fromarray(np.asarray(F).astype(np.uint8),mode="RGB")
ToShow = Image.fromarray(np.asarray(new_image).astype(np.uint8),mode="RGB")
ToShowB = Image.fromarray(np.asarray(B).astype(np.uint8),mode="RGB")

print(ToShow.size)

ToShowA.save('sharped.jpg')
ToShow.save('oversharped.jpg')
ToShowB.save('blur.jpg')
