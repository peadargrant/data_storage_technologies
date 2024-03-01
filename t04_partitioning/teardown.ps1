#!/usr/bin/env pwsh

$StackName = 'partitioning'

Write-Host "deleting $StackName stack..."
aws cloudformation delete-stack --stack-name $StackName

Write-Host "waiting for deletion to complete..."
aws cloudformation wait stack-delete-complete --stack-name $StackName

Write-Host "lab stack has been deleted from your aws account" -ForegroundColor Green


