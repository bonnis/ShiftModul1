#!/bin/bash

chr(){
    printf "\x$(printf %x $1)"
}

if [ ! -d "clog" ]
then
    mkdir "clog"
fi

filename=`date "+%H:%M %d-%m-%Y"`
offset=`date "+%-H"`

let letterb=65+$offset-1
let letterbend=$letterb+1

let letters=97+$offset-1
let lettersend=$letters+1


cat /var/log/syslog | tr '[A-Za-z]' "[$(chr $letterbend)-ZA-$(chr $letterb)$(chr $lettersend)-za-$(chr $letters)]" > ./clog/"$filename".txt
