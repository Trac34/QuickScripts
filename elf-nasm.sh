#!/bin/bash

if [ $# -ne 1 ];then exit; fi;
if ! [ -f $1 ];then exit; fi;

file=$( echo $1 | cut -d. -f1 )
echo -e "[+] Compiling $1 with NASM...."
nasm -felf $1
#if [ $? -eq 0 ];then echo -e "[++]Compiled.\n"; fi;
if [ $? -ne 0 ]; then echo -e "[!!!] Unable to compbile\n"; exit 1; fi;
if [ -f $file.o ];then
	echo -e "[+] Linking $file.o with ld..."
	ld -o $file $file.o
fi;

echo -e "[+] Done [+]\n"
ls -l $file
echo "================================"
file $file
