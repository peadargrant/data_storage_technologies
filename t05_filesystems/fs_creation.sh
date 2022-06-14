# review help text and manpage
mkfs -h
man mkfs

# check where mkfs is located (usually /sbin)
which mkfs

# from that, find the available filesystems
ls -l /sbin | grep mkfs

# creating a filesystem (aka formatting)
# e.g. make an ext4 on /dev/sdb1
mkfs -t ext4 /dev/sdb1

