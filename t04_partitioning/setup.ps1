#!/usr/bin/env pwsh

$StackName='partitioning'
$KeyFile='~/.ssh/id_ed25519.pub'

if ( !(Test-Path $KeyFile) ) {
    Write-Host 'no ed25519 key file found'
    Write-Host 'you should run: ssh-keygen -t ed25519 '
    Write-Host' and try again.'
}

Write-Host "importing public key file..."
aws ec2 import-key-pair --key-name ED25519_KEY --public-key-material fileb://$KeyFile

Write-Host "creating $StackName stack..."
aws cloudformation create-stack --stack-name $StackName --template-body file://partitioning_template.yml

Write-Host "waiting for $StackName stack to complete creating..."
aws cloudformation wait stack-create-complete --stack-name $StackName

Write-Host "WARNING!" -ForegroundColor Red -BackgroundColor White
Write-Host "MAKE SURE TO DELETE STACK USING ./teardown.ps1 WHEN FINISHED!" -ForegroundColor Red

Write-Host "lab is ready" -ForegroundColor Green

./get_ip.ps1



