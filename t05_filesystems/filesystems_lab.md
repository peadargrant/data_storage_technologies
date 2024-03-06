# Filesystem lab

## Setup using AWS

1. Make sure AWS CLI works and you have an `id_ed25519` key.

2. Run `setup.ps1` to set up the lab on your AWS account.

3. Use `./get_ip.ps1` to get the IP address.

4. Connect over SSH using `ssh ec2-user@ipaddresshere`.

Continue on to filesystems exercise


## Filesystems on Linux 

0. Partition the /dev/xvdb block device into two equal halves.
   You should have `/dev/xvdb1` and `/dev/xvdb2` device nodes in the `/dev` directory.

1. Use `mkfs` command to create ext4 filesystem on `/dev/xvdb1`. 

2. `mkfs` internally uses other commands like `mkfs.ext4`.
   It will need `mkfs.vfat` to format a FAT32 partition.
   Check if `mkfs.vfat` is installed by trying to run it, or type `which mkfs.vfat` to show its path if installed.
   If it's there just skip to the next instruction.
   If not, you will need to install the `dosfstools` package which contains `mkfs.vfat`. 
   Install `dosfstools` using the package manager (yum/apt depending on Linux distribution). 
   
3. Use `mkfs` (NOT `mkfs.vfat` itself) to create vfat filesystem on /dev/xvdb2. 

4. Create mountpoints (folders) in `/mnt` for `ext4_storage` and `vfat_storage`. 

4. Mount both manually as `/mnt/ext4_storage` and `/mnt/vfat_storage`. 

5. Use the `mount` command to confirm that these are both mounted.

6. Reboot the instance using `reboot`.
   This will disconnect your SSH session.
   Wait a minute or so for the instance to reboot.

7. Reconnect your SSH session.

8. Re-run the `mount` command. Are your `ext4_storage` and `vfat_storage` partitions still mounted?

9. Modify `/etc/fstab` to enable automatic mounting of your `ext4_storage` and `vfat_storage` partitions.

10. Test that you can mount / unmount both by reference to their mountpoints alone (not needing to pass `/dev/xvdb1` to the `mount` command.

11. Confirm that your mounts now persist across reboots by invoking a reboot on the instance.

