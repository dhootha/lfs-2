#!/bin/bash
# little script to remount lfs partition at /mnt/lfs
# and take care of stuff

sudo mount /dev/sdb1 /mnt/lfs
sudo swapon /dev/sdb2
export LFS=/mnt/lfs

