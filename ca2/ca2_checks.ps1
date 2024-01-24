#!/usr/bin/env pwsh
# Check script for file submissions

Write-Host "Checks for Data Storage Tech CA2\n"

$files = @(@("aims.txt"), @("architecture.pdf"), @("implementation.pdf"), @("limitations.txt"))

$problems = 0
$check = 0

foreach ($variants in $files) {
	$check++
	"check no $check :"
	foreach ($file in $variants) {
		$found = $false
		"`t$file"

	if ( Test-Path $file -PathType Leaf ) {
	" ... found $file OK"
	$found = $true
	break
	}
}

	if ( $found -lt 1 ) {
	" ... not found any of the above"
	$problems = $problems + 1
	}


}

"issues detected: $problems"

if ( $problems -gt 0 ) {
   "ACTION REQUIRED: $problems problems need to be fixed"
   "Re-run script when fixed to confirm before submission"
}
else {
     "All OK, ready for submission."
}

