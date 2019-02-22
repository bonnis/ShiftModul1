#!/bin/bash

if [ ! -f "$1" ]
then
    echo "File does not exist."
    exit
fi

chr(){
    printf "\x$(printf %x $1)"
}

ord(){
    printf '%d' "$1"
}

offset=$(echo -n "$(echo -n $(basename $1) | cut -c1-2)" | tr -d '0')

let letterb=65+$offset-1
let letterbend=$letterb+1

let letters=97+$offset-1
let lettersend=$letters+1

cat "$1" | tr "[$(chr $letterbend)-ZA-$(chr $letterb)$(chr $lettersend)-za-$(chr $letters)]" '[A-Za-z]' > ./"$1-decrypted".txt
