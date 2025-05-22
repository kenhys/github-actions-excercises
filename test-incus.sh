#!/usr/bin/bash

set -eux

image=$1
test_file=$2

echo "::group::Run test: launch $image"
sudo incus launch $image target --debug
sleep 5
echo "::endgroup::"

echo "::group::Run test: configure $image"
sudo incus config device add target host disk source=$PWD path=/host
sudo incus list
echo "::endgroup::"

echo "::group::Run test: $test_file $other_args on $image"
sudo incus exec target -- /host/$test_file
echo "::endgroup::"

echo "::group::Run test: cleanup $image"
sudo incus stop target
sudo incus delete target
echo "::endgroup::"

echo -e "\nAll Success!\n"
