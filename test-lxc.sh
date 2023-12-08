#!/usr/bin/bash

set -x

lxc image list images:

#lxc-checkconfig
lxc launch $1 target
sleep 5
lxc config device add target host disk source=$PWD path=/host
lxc list
# + lxc list
# +--------+---------+------+---------------------------------------------+-----------+-----------+
# |  NAME  |  STATE  | IPV4 |                    IPV6                     |   TYPE    | SNAPSHOTS |
# +--------+---------+------+---------------------------------------------+-----------+-----------+
# | target | RUNNING |      | fd42:60b:f54:e1b4:216:3eff:fe1c:83e3 (eth0) | CONTAINER | 0         |
# +--------+---------+------+---------------------------------------------+-----------+-----------+
case $1 in
    *debian*|*ubuntu*)
	lxc exec target -- /host/test-apt.sh
	;;
    *rocky*|*alma*)
	lxc exec target -- /host/test-yum.sh
	;;
esac
lxc stop target
lxc delete target
