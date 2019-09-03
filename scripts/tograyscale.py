#!/usr/bin/python
from PIL import Image
import numpy as np
im = Image.open('halcon.jpg', 'r')

Imag = list(im.getdata())

width, height = im.size
I = []

for i in range(0,height):
    row = []
    for j in range(0,width):
        r,g,b = Imag[width*i+j]
        gray = int((r+g+b)/3)
        row.append(gray)
    I.append(row)


im.close()


f= open("image","wb+")

print(width)
print(height)

print(bytearray.fromhex('{:016x}'.format(width)) )
print(bytearray.fromhex('{:016x}'.format(height)) )

f.write( bytearray.fromhex('{:08x}'.format(width)) )
f.write( bytearray.fromhex('{:08x}'.format(height)) )



for i in range(0,height):
	f.write(bytearray(I[i]))
f.close()
