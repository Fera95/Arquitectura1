#!/bin/bash

echo "compiling Examples/branch.s"
./arm-compiler-dbg Examples/branch.s compilation/branch.o
echo "compiling Examples/kernel.s"
./arm-compiler-dbg Examples/kernel.s compilation/kernel.o
echo "compiling Examples/memory.s"
./arm-compiler-dbg Examples/memory.s compilation/memory.o
echo "compiling Examples/register.s"
./arm-compiler-dbg Examples/register.s compilation/register.o

