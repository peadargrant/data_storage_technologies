Function CHS-To-LBA([int]$C, [int]$H, [int]$S, [int]$HPC, [int]$SPT) {

$LBA = ( $C * $HPC + $H ) * $SPT + ( $S - 1 )

}

