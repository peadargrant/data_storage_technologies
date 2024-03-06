# Partitioning lab


## Setup using lab machine

On your assigned lab server machine: 

1. Install `parted` if not already installed.

2. Look in /dev and see if you can see 2nd drive (sdb).

Skip on ahead to partitioning exercise.


## Setup using AWS

1. Make sure AWS CLI works and you have an `id_ed25519` key.

2. Run `setup.ps1` to set up the lab on your AWS account.

3. Use `./get_ip.ps1` to get the IP address.

4. Connect over SSH using `ssh ec2-user@ipaddresshere`.

Continue on to partitioning exercise


## Partitioning exercise

1. Start `parted` on the 2nd drive. 

2. Make a new MBR partition table. 

3. Make 2 partitions as follows: 

	Partition 1 : 50% of disk, indicated type ext4
	Partition 2 : 50% of disk, indicated type fat32
	
6. Confirm that the partitions are visible in /dev directory.

7. Print the partition table on your root drive and the 2nd drive. 


## Teardown

Use `./teardown.ps1` to remove the stack (set of resources including the EC2 and an EBS volume) from your AWS account.

It is **very important** that you do this to **avoid unnecessary charges**.

