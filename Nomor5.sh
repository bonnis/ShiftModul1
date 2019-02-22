#!/bin/bash
cd ~/
if [ -d "./modul1" ]; then
	cd modul1
else
	mkdir modul1
	cd modul1
fi

awk '(tolower($0) ~ /cron/)&&(tolower($0) !~ /sudo/)&&(NF<13) {print}' /var/log/commands.log > logs

