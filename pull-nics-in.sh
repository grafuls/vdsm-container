#!/bin/bash -xe

tmp=$(mktemp -d -u --tmpdir=/host/tmp)
mkdir -p $tmp
container_tmp=${tmp#/host}
container_id=$(chroot /host docker ps -q -f "ancestor=tlitovsk/vdsm-container" -f "status=running")

cp /root/move-nics.sh $tmp/move-nics.sh
chroot /host ./$container_tmp/move-nics.sh $container_id ens9

rm -rf $tmp