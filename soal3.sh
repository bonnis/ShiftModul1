#!/bin/bash

length=12
digit=({0..9})
lower=({a..z})
upper=({A..Z})
charArray=(${digit[*]}${lower[*]}${upper[*]})
arrayLength=${#charArray[*]}
password=""
let minimum=$length-5
pass=0

while [[ $pass != 1 ]]; do
    cnt=0;
    isUp=0
    isLo=0
    isNum=0
    for i in `seq 1 $length`
    do
        
        if [[ $minimum -ge $cnt ]]; then
            index=$((RANDOM%arrayLength))
            char=${charArray[$index]}
            if [[ $char =~ [A-Z] ]]; then
                isUp=1
            elif [[ $char =~ [a-z] ]]; then
                isLo=1
            elif [[ $char =~ [0-9] ]]; then
                isNum=1
            fi
            password=${password}${char}
        else
            if [[ isUp -eq 0 ]]; then
                index=$((RANDOM%26))
                char=${upper[$index]}
                password=${password}${char}
                isUp=1;
            elif [[ isLo -eq 0 ]]; then
                index=$((RANDOM%26))
                char=${lower[$index]}
                password=${password}${char}
                isLo=1;
            elif [[ isNum -eq 0 ]]; then
                index=$((RANDOM%10))
                char=${digit[$index]}
                password=${password}${char}
                isNum=1
            else
                index=$((RANDOM%arrayLength))
                char=${charArray[$index]}
                password=${password}${char}
            fi
        fi
    (( ++cnt ))
    done

    file=password
    number=1
    pass=1

    while test -e "$file$number.txt"; do
        if [ $(cat "$file$number.txt") == $password ]; then
            pass=0
        fi
        (( ++number ))
    done
done

fname="$file$number.txt"

echo $password > "$fname"