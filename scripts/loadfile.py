#!/usr/bin/python
from PIL import Image
import numpy as np

import sys



I = []

height = 128
width = 128

with open(sys.argv[1], "r") as f:
	byte = "-"
	while byte != b"":
		byte = f.read(2)
		print(byte)
		if (byte == ""):
			I.append(0)
		else:			
			I.append(int(byte,16))

	f.close()

Im = []

for i in range(0,width):
    row = []
    for j in range(0,height):
        row.append(I[height*i+j])
    Im.append(row)



ToShowA = Image.fromarray(np.asarray(Im).astype(np.uint8),mode="L")

ToShowA.save(sys.argv[2])



