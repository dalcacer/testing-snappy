tc qdisc add dev eth0 handle 1: root htb default 11
tc class add dev eth0 parent 1: classid 1:1 htb rate 20kbps
tc class add dev eth0 parent 1:1 classid 1:11 htb rate 20kbps

#ingress policing
#attach ingress policer:
tc qdisc add dev eth0 handle ffff: ingress
## filter *everything* to it (0.0.0.0/0), drop everything that's
## coming in too fast:
tc filter add dev eth0 parent ffff: protocol ip prio 50 u32 match ip src 0.0.0.0/0 police rate 20kbit burst 10k drop flowid :1
