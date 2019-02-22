#!/bin/bash

data=`awk -F ',' '$7=="2012"{array[$1]=array[$1]+$10}END{for(i in array) print i "," array[i]}' WA_Sales_Products_2012-14.csv | sort -t ',' -nrk2  | awk -F ',' 'NR==1{print $1}'`

echo $data

dataraw=`awk -F ',' -v add="$data" '($1 ~ add)&&($7=="2012"){array[$4]=array[$4]+$10}END{for (i in array) print i "," array[i]}' WA_Sales_Products_2012-14.csv | sort -t ',' -nrk2 | awk  -F ',' 'NR<3 {print $1 ", "} NR==3{print $1}'`

data1=`echo -n -e $dataraw | awk -F ', ' 'NR==1 {print $1}'`
echo $data1

data2=`echo -n -e $dataraw | awk -F ', ' 'NR==1 {print $2}'`
echo $data2

data3=`echo -n -e $dataraw | awk -F ', ' 'NR==1 {print $3}'`
echo $data3

echo -n $data1 " : "
data1=`awk -F ',' -v add="$data" -v add1="$data1" '($1 ~ add)&&($4 ~ add1)&&($7=="2012") {array[$6]=array[$6]+$10}END{for (i in array) print i "," array[i]}' WA_Sales_Products_2012-14.csv | sort -t ',' -nrk2 | awk  -F ',' 'NR<3 {print $1 ", "} NR==3{print $1}'`
echo $data1

echo -n $data2 " : "
data2=`awk -F ',' -v add="$data" -v add1="$data2" '($1 ~ add)&&($4 ~ add1)&&($7=="2012") {array[$6]=array[$6]+$10}END{for (i in array) print i "," array[i]}' WA_Sales_Products_2012-14.csv | sort -t ',' -nrk2 | awk  -F ',' 'NR<3 {print $1 ", "} NR==3{print $1}'`
echo $data2

echo -n $data3 " : "
data3=`awk -F ',' -v add="$data" -v add1="$data3" '($1 ~ add)&&($4 ~ add1)&&($7=="2012") {array[$6]=array[$6]+$10}END{for (i in array) print i "," array[i]}' WA_Sales_Products_2012-14.csv | sort -t ',' -nrk2 | awk  -F ',' 'NR<3 {print $1 ", "} NR==3{print $1}'`
echo $data3
