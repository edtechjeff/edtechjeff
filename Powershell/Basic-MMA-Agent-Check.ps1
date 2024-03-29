#get all the Log Analytics Workspace 
$all_workspace = Get-AzOperationalInsightsWorkspace


#here, I hard-code a vm name for testing purpose. If you have more VMs, you can modify the code below using loop.

$myvm_name = "vm name"
$myvm_resourceGroup= "resource group name of the vm"

#for windows vm, the value is fixed as below
$extension_name = "MicrosoftMonitoringAgent"

$myvm = Get-AzVMExtension -ResourceGroupName $myvm_resourceGroup -VMName $myvm_name -Name $extension_name

$workspace_id = ($myvm.PublicSettings | ConvertFrom-Json).workspaceId

#$workspace_id

foreach($w in $all_workspace)
{
if($w.CustomerId.Guid -eq $workspace_id)
  { 
  #here, I just print out the vm name and the connected Log Analytics workspace name
  Write-Output "the vm: $($myvm_name) writes log to Log Analytics workspace named: $($w.name)"
  }
}