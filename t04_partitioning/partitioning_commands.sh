# Partition commands
# Peadar Grant
exit # not intended to run as script!

# Open partition editor on a specific disk (e.g. /dev/sdb)
# (must be root to do this, use su if needed!)
sudo parted /dev/sdb

# included online help
help

# print the partition table 
p

# new MBR partition table
mktable msdos

# new partition (covering whole disk 0 to 100%)
mkpart primary ext4 0 100%

# remove numbered partition 1 (from printed list)
rm 1
