#!/bin/bash

while :
do

arp-scan --localnet > current_state
head -n -2 current_state > curr && mv curr current_state
if [[ -f old_state ]]
then
DISCONNECTED=$(awk 'NR==FNR{a[$0];next}!($0 in a)' current_state old_state)
CONNECTED=$(awk 'NR==FNR{a[$0];next}!($0 in a)' old_state current_state)
fi
head -n -2 current_state > oldd && mv oldd old_state
cp current_state old_state

if [[ ! -z $DISCONNECTED ]]
then
echo "DISCONNECTED:==="
echo "${DISCONNECTED}"
date
fi
if [[ ! -z $CONNECTED ]]
then
echo "CONNECTED:   ==="
echo "${CONNECTED}"
date
fi
sleep 11
done
