#!/bin/zsh


if [ $# -eq 0 -o $# -eq 1 ];then
    echo "$0 [1, 256, 512] file_to_hash checksum_to_compare"
    echo "The program will default to sha256 if a number is not supplied"
    exit
fi
if [ $# -eq 2 ];then
    a=256 # Default to sha256 if only file and checksum 
    if ! [ -f $1 ];then
        echo "IF passing only file and checksum, file must be first."
        exit
    fi
    f=$1
    c=$2
fi
if [ $# -eq 3 ];then
    re='^[0-9]+$'
    if ! [[ $1 =~ $re ]];then
        echo "Error. Arg failed. [optional_number] file checksum"
        echo "Figure it out bub."
        exit
    fi
    a=$1
    if ! [ -f $2 ];then
        echo "IF passing number, file, and checksum, they must be in that order."
        exit
    fi
    f=$2
    c=$3
fi

x=$(shasum -a $a $f | awk '{print $1}')
if ! [ $x = $c ];then
    echo "[-] CheckSums do not match! [-]"
    echo "$x != $c"
    echo
    exit
fi
echo "[+] CheckSums Match! [+]"
