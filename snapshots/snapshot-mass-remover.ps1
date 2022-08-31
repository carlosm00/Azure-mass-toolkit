<#
    .Description
   Project: snapshot-mass-remover
   Author/Autor: Carlos Mena (https://github.com/carlosm00)
   Definition: PowerShell CLI script for snapshot mass removal.

   How to use:

   snapshot-mass-remover.ps1 <subscription> <resource group> <file route>
#>

# Arguments asigned to variables:
# Subscription
$sub=$args[0]
# Resource Group
$rg=$args[1]
# File containing the item list
$file = Get-Content -Path $args[2]

try{
# We set AZ Subscription context
    az account set --subscription "$sub"

    # We iterate through the file
    foreach ($lines in $file){
        az snapshot delete --resource-group "$rg" --name "$lines"
        Write-Host "Deleted $lines in $rg ($sub)"
    }
}
catch {
    $message = $_.Exception.message
    $error_type = $_.Exception.GetType()
    Write-Output "$error_type : $message"
}