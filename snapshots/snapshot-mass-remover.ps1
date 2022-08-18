<#
    .Description
   Project: snapshot-mass-remover
   Author/Autor: Carlos Mena (https://github.com/carlosm00)
   Definition: PowerShell CLI script for snapshot mass removal.

   How to use:

   snapshot-mass-remover.ps1 <subscription> <resource group> <file route>
#>

$sub=$args[0]
$rg=$args[1]
$file = Get-Content -Path $args[2]

az account set --subscription "$sub"
foreach ($lines in $file){
    az snapshot delete --resource-group "$rg" --name "$lines"
    Write-Host "Deleted $lines in $rg ($sub)"
}