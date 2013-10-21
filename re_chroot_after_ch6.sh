# A little script to re-enter the LFS chroot
# ...to be run as root...
export LFS=/mnt/lfs
mount -v --bind /dev $LFS/dev
mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
if [ -h $LFS/dev/shm ]; then
  link=$(readlink $LFS/dev/shm)
  mkdir -p $LFS/$link
  mount -vt tmpfs shm $LFS/$link
  unset link
else
  mount -vt tmpfs shm $LFS/dev/shm
fi
chroot "$LFS" /usr/bin/env -i 	\
  HOME=/root TERM="$TERM" 	\
  PS1='\u:\w\$ '		\
  PATH=/bin:/usr/bin:/sbin:/usr/sbin \
  /bin/bash --login
