#!/bin/bash

set -x

#lxc-checkconfig
lxc launch $1 target
lxc config device add target host disk source=$PWD path=/host
lxc list
lxc exec target -- /host/test-apt.sh
lxc stop target
lxc delete target
