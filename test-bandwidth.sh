#!/bin/bash
OUT=snappy-bandwidth.txt
cat /dev/null > $OUT

function measure() {
  echo "$1 bandwidth" >> $OUT
  #egress
  tc qdisc add dev eth0 handle 1: root htb default 11
  tc class add dev eth0 parent 1: classid 1:1 htb rate $1kbps
  tc class add dev eth0 parent 1:1 classid 1:11 htb rate $1kbps

  #ingress policing
  #attach ingress policer:
  tc qdisc add dev eth0 handle ffff: ingress
  ## filter *everything* to it (0.0.0.0/0), drop everything that's
  ## coming in too fast:
  tc filter add dev eth0 parent ffff: protocol ip prio 50 u32 match ip src 0.0.0.0/0 police rate ${1}kbit burst 10k drop flowid :1


  for i in {1..5}
  do
    (time snappy install xkcd-webserver) 2>> $OUT
    sudo snappy remove xkcd-webserver

    sleep 5
  done

  tc qdisc del dev eth0 root
  tc qdisc del dev eth0 ingress
}


#for i in 102400 24576 3072 2048 1024 250 40 20
for i in 2048 1024 250 40 20
  do
    measure $i
  done
