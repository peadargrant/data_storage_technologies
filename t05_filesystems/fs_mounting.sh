# review mount command
mount -h #inbuilt help
man mount #man page

# create the mountpoint (-p allows it to already exist)
mkdir -p /mnt/data

# issue the mount}
mount -t ext4 /dev/sdb1 /mnt/data

# viewing mounted systems
mount

