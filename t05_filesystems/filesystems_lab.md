% Filesystem lab

Assume we already have /dev/sdb partitioned in half as /dev/sdb1 and /dev/sdb2.
On your assigned lab server machine: 

1. Use `mkfs` command to create ext4 filesystem on /dev/sdb1. 

2. `mkfs` internally uses other commands like `mkfs.ext4`.
   It will need `mkfs.vfat` to format a FAT32 partition. 
   `mkfs.vfat` is part of the `dosfstools` package. 
   Install `dosfstools` using `apt`. 
   
3. Use `mkfs` (NOT `mkfs.vfat`) to create vfat filesystem on /dev/sdb2. 

4. Mount both as `/mnt/ext4_storage` and `/mnt/vfat_storage`. 

