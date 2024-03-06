#!/usr/bin/env pwsh

$StackName = ((Split-Path -Path (Get-Location) -Leaf) -split "_",2)[1]
$PublicIp = ((aws cloudformation describe-stacks --stack-name $StackName | ConvertFrom-Json).Stacks[0].Outputs | Where-Object OutputKey -eq PublicIp)[0].OutputValue

Write-Host "instance public IP is: $PublicIp" -ForegroundColor Cyan
Write-Host "login over SSH using: ssh ec2-user@$PublicIp" -ForegroundColor Cyan

