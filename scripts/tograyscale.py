#!/usr/bin/python
from PIL import Image
import numpy as np
import sys
import os.path

bitl = int(sys.argv[1])

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
    if (bitl == 1): 
        return format(num, '02x')
    elif (bitl == 2):
        return format(num, '02x')
    else:
        return format(num, '02x')

def dumpImage(I,dest,w,h):
    f= open(dest,"w+")
    #f.write(decToHex(w) + "\n")
    #f.write(decToHex(w + w%2) + "\n")
    #f.write(decToHex(h) + "\n")
    if bitl == 1:
        for row in range(0,h):
            for col in range(0,w):
                mem = decToHex(I[row][col])+ "\n"
                f.write(mem)
            if w%2 ==1:
                mem = decToHex(I[row][col]) + "\n"
                f.write(mem)
    elif bitl == 2: 
        print("type 2")
        for row in range(0,h):
            col = 0
            while (col < w):
                mem = decToHex(I[row][col]) + decToHex(I[row][col+1]) + "\n"
                f.write(mem)
                col = col + 2
    f.close()


def main():
    if len(sys.argv) == 4:
        source = sys.argv[2]
        dest = sys.argv[3]
        if (os.path.isfile(source)):
            (I,w,h) = loadImageIntoMatrix(source)
            print("Image size: " +str(w + w%2) + "x"+str(h))
            dumpImage(I,dest,w,h)
    else:
        print ("required 3 parameters")

if __name__ == "__main__":
    main()
