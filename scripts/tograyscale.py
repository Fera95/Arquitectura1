#!/usr/bin/python
from PIL import Image
import numpy as np
import sys
import os.path



def loadImageIntoMatrix(source):
    im = Image.open(source, 'r')
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
    return (I,width,height)


def decToHex(num):
    return format(num, '02x')
    #return format(num, '04x')


def dumpImage(I,dest,w,h):
    f= open(dest,"w+")
    f.write(decToHex(w) + "\n")
    #f.write(decToHex(w + w%2) + "\n")
    f.write(decToHex(h) + "\n")
    for row in range(0,h):
        for col in range(0,w): #/2):
            #mem = decToHex(I[row][col]*256 + I[row][col+1])+ "\n"
            mem = decToHex(I[row][col])+ "\n"
    	    f.write(mem)
	"""
        if w%2 ==1:
            mem = decToHex(I[row][col]*256) + "\n"
            f.write(mem)
	"""
    f.close()


def main():
    if len(sys.argv) == 3:
        source = sys.argv[1]
        dest = sys.argv[2]
        if (os.path.isfile(source)):
            (I,w,h) = loadImageIntoMatrix(source)
            print("Image size: " +str(w + w%2) + "x"+str(h))
            dumpImage(I,dest,w,h)
    else:
        print ("required 3 parameters")

if __name__ == "__main__":
    main()
