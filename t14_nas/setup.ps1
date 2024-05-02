#!/usr/bin/env pwsh
# Creates stack from lab template based on folder name
# Peadar

$StackName=((Split-Path -Path (Get-Location) -Leaf) -split "_",2)[1] -replace '_','-'

Write-Host "creating $StackName stack..."
aws cloudformation create-stack --stack-name $StackName --template-body file://lab_template.yml

Write-Host "waiting for $StackName stack to complete creating..."
aws cloudformation wait stack-create-complete --stack-name $StackName

Write-Host "WARNING!" -ForegroundColor Red -BackgroundColor White
Write-Host "Passwords employed are NOT secure!" -ForegroundColor Red
Write-Host "There are multiple instances created which costs money!" -ForegroundColor Red
Write-Host "MAKE SURE TO DELETE STACK USING ./teardown.ps1 WHEN FINISHED!" -ForegroundColor Red

Write-Host "lab is ready" -ForegroundColor Green

./get_ip.ps1

