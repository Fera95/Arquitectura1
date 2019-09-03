#!/usr/bin/python
from PIL import Image
import numpy as np




I = []

height = 0
width = 0

with open("image", "rb") as f:
	byte = f.read(4)
	height = int("".join(format(ord(x), '08b') for x in byte),2) 
	print( "First 4 bytes" + str(int("".join(format(ord(x), '08b') for x in byte),2)) )
	byte = f.read(4)
	width = int("".join(format(ord(x), '08b') for x in byte),2)
	print( "First 4 bytes" + str(int("".join(format(ord(x), '08b') for x in byte),2)) )
    	while byte != b"":
        	# Do stuff with byte.
        	byte = f.read(1)
		if (byte == ""):
			I.append(0)
		else:			
			I.append(int("".join(format(ord(x), '08b') for x in [byte]),2))

	f.close()

Im = []

for i in range(0,width):
    row = []
    for j in range(0,height):
        row.append(I[height*i+j])
    Im.append(row)



ToShowA = Image.fromarray(np.asarray(Im).astype(np.uint8),mode="L")

ToShowA.save('grayscale.jpg')



