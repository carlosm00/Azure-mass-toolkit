<#
    .Description
    Project: mass-disk-exist
    Author/Autor: Carlos Mena (https://github.com/carlosm00)
    Definition: PowerShell CLI script for disk existence checker.

    How to use:

    snapshot-mass-remover.ps1 <subscription> <resource group> <file with disk names>
#>

$sub=$args[0]
$rg=$args[1]
$file = Get-Content -Path $args[0]

if (Get-ChildItem --name disk_exists.csv 2>&1)
{
    Write-Host "Vertting positive results into disk_exists.csv"
}
else {
    New-Item -Path . -Name 'disk_exists.csv' -ItemType "file"
    Write-Host "Vertting positive results into disk_exists.csv"
}

if (Get-ChildItem --name disk_dont_exists.csv 2>&1)
{
    Write-Host "...and disk_dont_exists.csv"
}
else {
    New-Item -Path . -Name 'disk_dont_exists.csv' -ItemType "file"
    Write-Host "...and disk_dont_exists.csv"
}

az account set --subscription "$sub"

foreach ($lines in $file){
    if (az disk show --name "$lines" --resource-group "$rg" 2>&1){
        Write-Host "$lines in $rg exists"
        Write-Output "$sub,$rg,$lines" | Export-CSV disk_exists.csv
    }
    else {
        Write-Host "$lines in $rg does NOT exist"
        Write-Output "$sub,$rg,$lines" | Export-CSV disk_dont_exists.csv
    }
}