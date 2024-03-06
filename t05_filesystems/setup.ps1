#!/usr/bin/env pwsh
# Creates stack from lab template based on folder name
# Peadar

$StackName=((Split-Path -Path (Get-Location) -Leaf) -split "_",2)[1]
$LinuxKeyFile='~/.ssh/id_ed25519.pub'

if ( !(Test-Path $LinuxKeyFile) ) {
    Write-Host 'no ed25519 key file found'
    Write-Host 'you should run: ssh-keygen -t ed25519 '
    Write-Host' and try again.'
}

$LinuxPublicKey = Get-Content $LinuxKeyFile

Write-Host "creating $StackName stack..."
aws cloudformation create-stack --stack-name $StackName --template-body file://lab_template.yml --parameters ParameterKey=ED25519Key,ParameterValue="$LinuxPublicKey"

Write-Host "waiting for $StackName stack to complete creating..."
aws cloudformation wait stack-create-complete --stack-name $StackName

Write-Host "WARNING!" -ForegroundColor Red -BackgroundColor White
Write-Host "MAKE SURE TO DELETE STACK USING ./teardown.ps1 WHEN FINISHED!" -ForegroundColor Red

Write-Host "lab is ready" -ForegroundColor Green

./get_ip.ps1

