# PowerShell partitioning commands
# Peadar Grant

# print out disks
get-disk

# format a particular drive
Clear-Disk -Number X -RemoveData

# create partition on drive #X, letter Y
New-Partition -DiskNumber X -UseMaximumSize -IsActive -DriveLetter Y
