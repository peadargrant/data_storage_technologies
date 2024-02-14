% Partitioning lab

On your assigned lab server machine: 

1. Install `parted` if not already installed.

2. Look in /dev and see if you can see 2nd drive (sdb).

3. Start `parted` on the 2nd drive. 

4. Make a new MBR partition table. 

5. Make 2 partitions as follows: 

	Partition 1 : 50% of disk, type ext4
	Partition 2 : 50% of disk, type fat32
	
6. Confirm that the partitions are visible in /dev directory.

7. Print the partition table on your /dev/sda drive. 

