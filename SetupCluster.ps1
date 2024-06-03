$secpasswd = ConvertTo-SecureString "Pass@@word2024" -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential ("azureadmin@contoso.local", $secpasswd)

Invoke-Command -ComputerName localhost -Credential $mycreds -ScriptBlock {
    # Your commands here
    Install-WindowsFeature -Name Failover-Clustering -IncludeManagementTools
    Start-Sleep -Seconds 30
    New-Cluster -Name Cluster-Lab -StaticAddress 10.0.1.200
    Start-Sleep -Seconds 30
    Add-ClusterNode -Name vm-member-01 -Cluster Cluster-Lab
    Start-Sleep -Seconds 30
    Add-ClusterNode -Name vm-member-02 -Cluster Cluster-Lab
    Start-Sleep -Seconds 30
    Enable-ClusterS2D
    New-Volume -StoragePoolFriendlyName S2D* -FriendlyName vdisk01 -FileSystem CSVFS_REFS -Size 300GB
}