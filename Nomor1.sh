#!/bin/bash
cd ~/
unzip nature.zip
cd ~/nature/
n=0
mkdir ./decoded/
for i in ~/nature/*.jpg
do
	bas="`basename $i`"
	base64 -d $i | xxd -r > ./decoded/$bas
done
