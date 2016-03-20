#!/bin/bash -xe

local tmp=$(mktemp -d -u --tmpdir=/host/tmp)
local container_tmp=${tmp#/host}
local container_id=$(chroot /host docker ps -q -f "ancestor=tlitovsk/vdsm-container" -f "status=running")

cp /root/move-nics.sh $tmp
chroot /container_tmp/move-nics.sh $container_id

rm -rf $tmp
