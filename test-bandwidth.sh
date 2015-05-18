#!/bin/bash
cat /dev/null > times

function measure() {
  echo "$1 bandwidth" >> times
  tc qdisc add dev eth0 handle 1: root htb default 11
  tc class add dev eth0 parent 1: classid 1:1 htb rate $1kbps
  tc class add dev eth0 parent 1:1 classid 1:11 htb rate $1kbps


  for i in {1..5}
  do
    (time snappy install webdm) 2>> times
    sudo snappy remove webdm

    sleep 1
  done

  tc qdisc del dev eth0 root
}


#for i in 102400 24576 3072 2048 1024 250 40 20
for i in 2048 1024 250 40 20
  do
    measure $i
  done
