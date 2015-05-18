#!/bin/bash
cat /dev/null > times

function measure() {
  echo "$1 package loss" >> times
  tc qdisc add dev eth0 root netem loss $1%

  for i in {1..5}
  do
    (time snappy install webdm) 2>> times
    sudo snappy remove webdm

    sleep 1
  done

  tc qdisc del dev eth0 root netem loss $1%
}



for i in {0..50..5}
  do
    measure $i
  done
