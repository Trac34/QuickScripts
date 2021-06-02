#!/bin/zsh

if [ $# -lt 1 ]; then exit 1; fi;

url="http://shell-storm.org/api/?s=$1"

if [ $# -gt 1 ];then
	for i in "$@"; do	
		url+="*$i";
	done;
fi;

curl $url
