#!/usr/bin/env python3
import sys

if len(sys.argv) != 2:
	sys.exit(1)

it = sys.argv[1]

print("String Length : {}".format(len(it)))

stringList = [it[i:i+4] for i in range(0, len(it), 4)]

for item in stringList[::-1]:
	print("{} : {}".format(item[::-1], bytes(item[::-1], "utf-8").hex() ) )
