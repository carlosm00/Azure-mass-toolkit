<#
    .Description
    Project: mass-disk-exist
    Author/Autor: Carlos Mena (https://github.com/carlosm00)
    Definition: PowerShell CLI script for disk existence checker.

    How to use:

    mass-disk-exist.ps1 <file with disk names>

    NOTE: File should have subscription, resource group and disk name, separated by commas.
#>

# File is provided as the only argument
$file = Get-Content -Path $args[0]

try{

    if (Get-ChildItem --name 'disk_exists.csv' 2>&1)
    {
        Write-Host "Vertting positive results into disk_exists.csv"
    }
    else {
        New-Item -Path . -Name 'disk_exists.csv' -ItemType "file"
        Write-Host "Vertting positive results into disk_exists.csv"
    }

    if (Get-ChildItem --name 'disk_dont_exists.csv' 2>&1)
    {
        Write-Host "...and negative disk_dont_exists.csv"
    }
    else {
        New-Item -Path . -Name 'disk_dont_exists.csv' -ItemType "file"
        Write-Host "...and negative disk_dont_exists.csv"
    }

    foreach ($lines in $file){

        $obj = $lines.Split(',', 3)
        $sub = $obj[0] 
        $rg = $obj[1] 
        $disk = $obj[2]

        if (az disk show --subscription "$sub" --name "$disk" --resource-group "$rg" 2>&1){
            Write-Host "$lines in $rg ($sub) exists"
            Write-Output "$sub,$rg,$disk" | Export-CSV disk_exists.csv
        }
        else {
            Write-Host "$disk in $rg ($sub) does NOT exist"
            Write-Output "$sub,$rg,$disk" | Export-CSV disk_dont_exists.csv
        }
    }
}
catch{
    $message = $_.Exception.message
    $error_type = $_.Exception.GetType()
    Write-Output "$error_type : $message"
}