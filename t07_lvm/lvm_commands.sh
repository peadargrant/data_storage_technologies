#!/usr/bin/env false
# LVM commands
# Peadar Grant

# Create a partition table on the drive
parted -s /dev/sda mklabel gpt

# Make a primary partition on whole drive
parted -s /dev/sda unit mib mkpart primary 1 100%

# Mark new primary partition as LVM}
parted -s /dev/sda set 1 lvm on

# create a physical volume from a disk/partition
pvcreate /dev/sda1
pvcreate /dev/sdb1 # similar for another disk/partition

# create volume group vg-01 composed of /dev/sda1 and /dev/sdb1
vgcreate vg01 /dev/sda1 /dev/sdb1

# create a 10GB logical volume on vg01 named vol_data
lvcreate -L 10G -n vol_data vg01



