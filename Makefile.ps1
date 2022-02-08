#!/usr/bin/env pwsh

# graphviz diagrams
Get-ChildItem "." -Filter *.gv | Foreach-Object {
    $source_file = $_.Name
    $destination_file = [io.path]::ChangeExtension($_.name, "pdf")
    Write-Host "converting $source_file to $destination_file ... " -NoNewline
    dot -Tpdf -o $destination_file $source_file
    Write-Host "done" -ForegroundColor green
}

# SVG to PDF
Get-ChildItem "." -Filter *.svg | Foreach-Object {
    $source_file = $_.Name
    $destination_file = [io.path]::ChangeExtension($_.name, "pdf")
    Write-Host "converting $source_file to $destination_file ... " -NoNewline
    
    Write-Host "done" -ForegroundColor green    
}

