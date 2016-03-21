#!/bin/bash -xe

chroot /host "/usr/bin/nsenter --net=/proc/1/ns/net --pid=/proc/1/ns/pid ip link set netns 1 ens9"
