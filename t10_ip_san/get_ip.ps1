#!/usr/bin/env pwsh

$StackName = ((Split-Path -Path (Get-Location) -Leaf) -split "_",2)[1] -replace '_','-'

$Outputs = (aws cloudformation describe-stacks --stack-name $StackName | ConvertFrom-Json).Stacks[0].Outputs

$ClientIp = ( $Outputs | Where-Object OutputKey -eq ClientIp)[0].OutputValue

Write-Host "client public IP is: $ClientIp" -ForegroundColor Cyan
Write-Host "login over SSH using: ssh ubuntu@$ClientIp" -ForegroundColor Cyan

$WindowsClientIp = ( $Outputs | Where-Object OutputKey -eq WindowsClientIp)[0].OutputValue

Write-Host "windows client public IP is: $WindowsClientIp" -ForegroundColor Cyan


$TargetIp = ( $Outputs | Where-Object OutputKey -eq TargetPublicIp)[0].OutputValue

Write-Host "target public IP is: $TargetIp" -ForegroundColor Cyan
Write-Host "login over SSH using: ssh ubuntu@$TargetIp" -ForegroundColor Cyan

$TargetPrivateIp = ( $Outputs | Where-Object OutputKey -eq TargetPrivateIp)[0].OutputValue

Write-Host "target private IP is: $TargetPrivateIp" -ForegroundColor Cyan



